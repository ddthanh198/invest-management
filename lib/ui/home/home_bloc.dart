import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AssetRepository repository;

  HomeBloc({required this.repository}) : super(GetDataAssetSuccess(listCategory: List.empty(growable: true)));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is GetDataAssetEvent) {
      try {
        final List<Category>? categories = await repository.getDataAsset();

        List<Future<List<Asset>>> listJobs = List.empty(growable: true);

        categories?.forEach((element) async {
          // List<Asset>? assets = await repository?.getAssetsWithCategoryId(element.id!);
          // if(assets != null) element.assets = assets;

          listJobs.add(repository.getAssetsWithCategoryId(element.id!));
        });

        int totalCapital = 0;
        int totalProfit = 0;
        int totalProfitPercent = 0;
        await Future.wait(listJobs).then((value) =>  {
          if(categories != null) {
            for(var i = 0; i < categories.length; i++) {
              categories[i].assets = value[i],

              // totalCapital = 0,
              // totalProfit = 0,
              // totalProfitPercent = 0,
              //
              //
              //
              // value[i].forEach((asset) {
              //   totalCapital += ((asset.capital != null) ? asset.capital : 0)!;
              //   totalProfit += ((asset.profit != null) ? asset.profit : 0)!;
              // }),
              //
              // if(totalCapital != 0) {
              //   totalProfitPercent = (totalProfit * 100 / totalCapital) as int
              // },
              //
              // categories[i].totalCapital = totalCapital,
              // categories[i].totalProfit = totalProfit,
              // categories[i].totalProfitPercent = totalProfitPercent,
            }
          }
        });

        yield GetDataAssetSuccess(listCategory: categories);
        // print("run here");

      } catch(exception) {
        yield GetDataAssetFailure();
      }
    }
  }
}