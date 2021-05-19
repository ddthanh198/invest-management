import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/model/add_category.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/category/category_event.dart';
import 'package:invest_management/ui/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{
  final AssetRepository? repository;

  CategoryBloc({@required this.repository}) : super(GetCategorySuccess(listCategory: List.empty(growable: true)));

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {

    if(event is GetCategoryEvent) {
      try {
        List<Category>? categories = await repository?.getCategory();
        categories?.add(AddCategoryModel());
        yield GetCategorySuccess(listCategory: categories);
      } catch(exception) {
        yield GetCategoryFailure();
      }
    }
  }
}