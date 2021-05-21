import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';

abstract class CategoryState {

}

class GetCategorySuccess extends CategoryState{
  List<Category>? listCategory;
  GetCategorySuccess({@required this.listCategory});
}

class GetCategoryFailure extends CategoryState{}

