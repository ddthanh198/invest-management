import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/model/add_category.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{
  final AssetRepository? repository;

  CategoryBloc({@required this.repository}) : super(GetCategorySuccess(listCategory: List.empty(growable: true))){
    on<GetCategoryEvent>((event, emit) => _handleGetCategoryEvent(event, emit));
  }

  void _handleGetCategoryEvent(GetCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      List<Category>? categories = await repository?.getCategory();
      if(categories == null) {
        categories = List.empty(growable: true);
      }

      categories.add(AddCategoryModel(null, null, null, null));

      emit(GetCategorySuccess(listCategory: categories));
    } catch(exception) {
      emit(GetCategoryFailure());
    }
  }
}