import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_asset/add_aseet_state.dart';
import 'package:invest_management/ui/add_asset/add_asset_event.dart';

class AddAssetBloc extends Bloc<AddAssetEvent, AddAssetState> {
  final AssetRepository? repository;

  AddAssetBloc({@required this.repository}) : super(AddAssetState()) {
    on<SaveAssetEvent>((event, emit) => _handleSaveAssetEvent(event, emit));
    on<UpdateAssetEvent>((event, emit) => _handleUpdateAssetEvent(event, emit));
    on<ValidateDataAssetEvent>((event, emit) => _handleValidateDataAssetEvent(event, emit));
  }

  void _handleSaveAssetEvent(SaveAssetEvent event, Emitter<AddAssetState> emit) async {
    repository?.saveAsset(event.asset);
    emit(SaveAssetSuccess());
  }

  void _handleUpdateAssetEvent(UpdateAssetEvent event, Emitter<AddAssetState> emit) async {
    repository?.updateAsset(event.asset);
    emit(UpdateAssetSuccess());
  }

  void _handleValidateDataAssetEvent(ValidateDataAssetEvent event, Emitter<AddAssetState> emit) async {
    if(
    event.name == "" ||
        event.capital == "" ||
        event.profit == "" ||
        event.profitPercent == ""
    ) {
      emit(ValidateDataAssetFailure());
    } else {
      emit(ValidateDataAssetSuccess());
    }
  }
}