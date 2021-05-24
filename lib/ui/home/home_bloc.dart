import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/data/model/pie_data.dart';
import 'package:invest_management/data/model/triple.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';

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
          // List<Asset>? assets = await repository?.getAssetsWithCategoryId(element.id!);
          // if(assets != null) element.assets = assets;

          listJobs.add(repository.getAssetsWithCategoryId(element.id!));
        });

        int totalCapital = 0;
        int totalProfit = 0;
        int totalProfitPercent = 0;

        int totalCapitalOfCategory = 0;
        int totalProfitOfCategory = 0;
        int totalProfitPercentOfCategory = 0;

        int capitalPercent;
        PieData pieData;
        Triple<int, int, int>? totalDataTriple;

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
                totalProfitPercentOfCategory = totalProfitOfCategory * 100 ~/ totalCapitalOfCategory
              },

              categories[i].totalCapital = totalCapitalOfCategory,
              categories[i].totalProfit = totalProfitOfCategory,
              categories[i].totalProfitPercent = totalProfitPercentOfCategory,

              totalCapital += totalCapitalOfCategory
            },

            for(var i = 0; i < categories.length; i++) {
              capitalPercent = categories[i].totalCapital * 100 ~/ totalCapital,
              totalProfit += categories[i].totalProfit,
              pieData =  PieData("capital", categories[i].totalCapital, HexColor(categories[i].color!) ,"$capitalPercent%"),
              if(categories[i].totalCapital != 0) {
                listPieData.add(pieData)
              }
            },

            if(totalCapital != 0) {
              totalProfitPercent = totalProfit * 100 ~/ totalCapital
            },

            totalDataTriple = Triple<int, int, int> (first: totalCapital, second: totalProfit, third: totalProfitPercent)
          }
        });

        yield GetDataAssetSuccess(listCategory: categories, listPieData: listPieData, totalDataTriple: totalDataTriple);
        // print("run here");

      } catch(exception) {
        yield GetDataAssetFailure();
      }
    }
  }
}