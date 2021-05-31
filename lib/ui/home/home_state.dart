import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/data/model/pie_data.dart';
import 'package:invest_management/data/model/triple.dart';

abstract class HomeState {}

class GetDataAssetSuccess extends HomeState {
  List<Category>? listCategory;
  List<PieData>? listPieData;
  Triple<int, int, int>? totalDataTriple;
  GetDataAssetSuccess({required this.listCategory, required this.listPieData, required this.totalDataTriple});
}

class GetDataAssetFailure extends HomeState{}

class DeleteCategorySuccess extends HomeState{}
class DeleteCategoryFailure extends HomeState{}

class DeleteAssetSuccess extends HomeState{}
class DeleteAssetFailure extends HomeState{}