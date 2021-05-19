import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';

abstract class HomeState {
  const HomeState();
}

class GetDataAssetSuccess extends HomeState {
  final List<Category>? listCategory;
  const GetDataAssetSuccess({@required this.listCategory});
}

class GetDataAssetFailure extends HomeState{

}