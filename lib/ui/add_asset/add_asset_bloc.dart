import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_aseet_state.dart';
import 'package:invest_management/ui/add_asset/add_asset_event.dart';

class AddAssetBloc extends Bloc<AddAssetEvent, AddAssetState> {
  final AssetRepository? repository;

  AddAssetBloc({@required this.repository}) : super(AddAssetState());

  @override
  Stream<AddAssetState> mapEventToState(AddAssetEvent event) async* {
    if(event is SaveAssetEvent) {
      repository?.saveAsset(event.asset);
      yield SaveAssetSuccess();
    } else if(event is UpdateAssetEvent) {
      repository?.updateAsset(event.asset);
      yield UpdateAssetSuccess();
    } else if(event is ValidateDataAssetEvent) {
      if(
        event.name == "" ||
        event.capital == "" ||
        event.profit == "" ||
        event.profitPercent == ""
      ) {
        yield ValidateDataAssetFailure();
      } else {
        yield ValidateDataAssetSuccess();
      }
    }
  }
}