import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/add_category/add_category_event.dart';
import 'package:invest_management/ui/add_category/add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState>{
  final AssetRepository? repository;

  AddCategoryBloc({@required this.repository}) : super(AddCategoryState());

  @override
  Stream<AddCategoryState> mapEventToState(AddCategoryEvent event) async* {
    if(event is SaveCategoryEvent) {
      repository!.saveCategory(event.category!);
      yield SaveCategorySuccess();
    }
    else if(event is EditCategoryEvent){
      repository!.updateCategory(event.category!);
      yield UpdateCategorySuccess();
    }
    else if(event is RefreshColorOrImage) {
      yield RefreshColorOrImageState();
    }
  }
}