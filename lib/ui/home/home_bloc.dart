import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/data/model/pair.dart';
import 'package:invest_management/data/model/pie_data.dart';
import 'package:invest_management/data/model/triple.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_aseet_state.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';
import 'package:invest_management/utils/extension/number_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AssetRepository repository;

  HomeBloc({required this.repository}) : super(GetDataAssetSuccess(listCategory: List.empty(growable: true), listPieData: List.empty(growable: true), totalDataTriple: Triple(first: 0, second: 0, third: 0)));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is GetDataAssetEvent) {
      try {
        final List<Category>? categories = await repository.getDataAsset();

        List<PieData>? listPieData = List.empty(growable: true);

        List<Future<List<Asset>>> listJobs = List.empty(growable: true);

        categories?.forEach((element) async {
          listJobs.add(repository.getAssetsWithCategoryId(element.id!));
        });

        int totalCapital = 0;
        int totalProfit = 0;
        double totalProfitPercent = 0;

        int totalCapitalOfCategory = 0;
        int totalProfitOfCategory = 0;
        double totalProfitPercentOfCategory = 0;

        double capitalPercent;
        PieData pieData;
        Triple<int, int, double>? totalDataTriple;

        await Future.wait(listJobs).then((value) =>  {
          if(categories != null) {
            for(var i = 0; i < categories.length; i++) {
              categories[i].assets = value[i],

              totalCapitalOfCategory = 0,
              totalProfitOfCategory = 0,
              totalProfitPercentOfCategory = 0,

              value[i].forEach((asset) {
                totalCapitalOfCategory += ((asset.capital != null) ? asset.capital : 0)!;
                totalProfitOfCategory += ((asset.profit != null) ? asset.profit : 0)!;
              }),

              if(totalCapitalOfCategory != 0) {
                totalProfitPercentOfCategory = toPrecision(totalProfitOfCategory * 100 / totalCapitalOfCategory)
              },

              categories[i].totalCapital = totalCapitalOfCategory,
              categories[i].totalProfit = totalProfitOfCategory,
              categories[i].totalProfitPercent = totalProfitPercentOfCategory,

              totalCapital += totalCapitalOfCategory
            },

            for(var i = 0; i < categories.length; i++) {
              if(totalCapital != 0) {
                capitalPercent = toPrecision(categories[i].totalCapital * 100 / totalCapital),
                totalProfit += categories[i].totalProfit,
                pieData =  PieData("capital", categories[i].totalCapital, HexColor(categories[i].color!) ,"$capitalPercent%"),
                if(categories[i].totalCapital != 0) {
                  listPieData.add(pieData)
                }
              }
            },

            if(totalCapital != 0) {
              totalProfitPercent = toPrecision(totalProfit * 100 / totalCapital)
            },

            categories.sort((a, b) => a.totalCapital.compareTo(b.totalCapital)),
            listPieData.sort((a, b) => a.yData.compareTo(b.yData)),

            totalDataTriple = Triple<int, int, double> (first: totalCapital, second: totalProfit, third: totalProfitPercent)
          }
        });

        yield GetDataAssetSuccess(listCategory: categories, listPieData: listPieData, totalDataTriple: totalDataTriple);
        // print("run here");

      } catch(exception) {
        print(exception);
        yield GetDataAssetFailure();
      }
    }
    else if(event is DeleteCategoryEvent) {
      yield await handleDeleteCategoryEvent(event);
    }
    else if(event is DeleteAssetEvent) {
      yield await handleDeleteAssetEvent(event);
    }
    else if(event is ExportAssetEvent) {
      yield await handleExportEvent(event);
    }
    else if (event is GetExportedFileEvent) {
      yield await handleGetExportedFileEvent(event);
    }
    else if(event is ImportAssetEvent) {
      yield await handleImportEvent(event);
    }
  }

  Future<HomeState> handleDeleteCategoryEvent(DeleteCategoryEvent event) async {
    try{
      List<Future<void>> listJobs = List.empty(growable: true);

      listJobs.add(repository.deleteCategory(event.category));

      await Future.wait(listJobs).then((value) => {

      });

      return DeleteCategorySuccess();
    } catch (error) {
      print(error);
      return DeleteCategoryFailure();
    }
  }

  Future<HomeState> handleDeleteAssetEvent(DeleteAssetEvent event) async {
    try {
      repository.deleteAsset(event.asset);
      return DeleteAssetSuccess();
    } catch (error) {
      return DeleteAssetFailure();
    }
  }

  Future<HomeState> handleExportEvent(ExportAssetEvent event) async {
    try {
      final List<Category>? categories = await repository.getDataAsset();
      List<Future<List<Asset>>> listJobs = List.empty(growable: true);

      categories?.forEach((element) async {
        listJobs.add(repository.getAssetsWithCategoryId(element.id!));
      });

      await Future.wait(listJobs).then((value) => {
        if(categories != null) {
          for(var i = 0; i < categories.length; i++) {
            categories[i].assets = value[i],
          }
        }
      });

      var statusExternalPermission = await Permission.storage.status;
      if(statusExternalPermission.isGranted) {
        var externalDirectory = await getExternalStorageDirectory();
        var now = new DateTime.now();
        var formatter = new DateFormat('yyyyMMdd_hhmmss');
        String formattedDate = formatter.format(now);

        File outputFile = File("${externalDirectory?.path}/backup_asset_$formattedDate.txt");

        String categoryString = jsonEncode(categories);

        outputFile.writeAsString(categoryString);

        return ExportAssetSuccess();
      } else if(statusExternalPermission.isDenied) {
        final status = await Permission.storage.request();
        if(status == PermissionStatus.permanentlyDenied) {
          return ExportAssetFailure(
              title: "Export thất bại!",
              content: "Vui lòng vào cài đặt để cấp quyền truy cập bộ nhớ cho ứng dụng!"
          );
        }
      }

      return ExportAssetFailure(title: "Export thất bại!");
    } catch (exception) {
      print("HomeBloc : handleExportEvent : $exception");
      return ExportAssetFailure(title: "Export thất bại!");
    }
  }

  Future<HomeState> handleImportEvent(ImportAssetEvent event) async {
    return ImportAssetFailure(title: "Import thất bại!");
  }

  Future<HomeState> handleGetExportedFileEvent(GetExportedFileEvent event) async {
    try {
      var externalDirectory = await getExternalStorageDirectory();
      var listPairPath = List<Pair<String, String>>.empty(growable: true);
      if(externalDirectory != null) {
        await for(var file in externalDirectory.list()) {
          var splitPaths = file.path.split('/');
          var fileName = splitPaths.last;
          if(fileName.length == "backup_asset_00000000_000000.txt".length && fileName.substring(0, "backup_asset".length) == "backup_asset") {
            var newPair = Pair<String, String>(first: file.path, second: fileName);
            listPairPath.add(newPair);
          }
        }
      }

      return GetExportedFileSuccess(listPath: listPairPath);
    } catch (exception) {
      print("HomeBloc : handleImportEvent : $exception");
      return GetExportedFileFailure(title: "Ko tìm thấy file!");
    }
  }
}