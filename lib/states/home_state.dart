import 'package:flutter/cupertino.dart';
import 'package:invest_management/model/category.dart';

abstract class HomeState {
  const HomeState();
}

class GetDataAssetSuccess extends HomeState {
  final List<Category> listCategory;
  const GetDataAssetSuccess({@required this.listCategory});
}

class GetDataAssetFailure extends HomeState{

}