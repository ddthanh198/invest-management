import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/events/home_event.dart';
import 'package:invest_management/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/states/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AssetRepository repository;

  HomeBloc({@required this.repository}) : super(GetDataAssetSuccess(listCategory: List.empty(growable: true)));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if(event is GetDataAssetEvent) {
      try {
        final List<Category> asset = await repository.getDataAsset();
        yield GetDataAssetSuccess(listCategory: asset);
      } catch(exception) {
        yield GetDataAssetFailure();
      }
    }
  }
}