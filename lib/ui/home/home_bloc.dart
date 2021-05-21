import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/home/home_event.dart';
import 'package:invest_management/ui/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AssetRepository? repository;

  HomeBloc({@required this.repository}) : super(GetDataAssetSuccess(listCategory: List.empty(growable: true)));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is GetDataAssetEvent) {
      try {
        final List<Category>? categories = await repository?.getDataAsset();

        categories?.forEach((element) async {
          List<Asset>? assets = await repository?.getAssetsWithCategoryId(element.id!);
          if(assets != null) element.assets = assets;
        });

        yield GetDataAssetSuccess(listCategory: categories);

      } catch(exception) {
        yield GetDataAssetFailure();
      }
    }
  }
}