import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';

abstract class HomeState {}

class GetDataAssetSuccess extends HomeState {
  List<Category>? listCategory;
  GetDataAssetSuccess({@required this.listCategory});
}

class GetDataAssetFailure extends HomeState{}