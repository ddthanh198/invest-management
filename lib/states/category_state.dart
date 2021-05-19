import 'package:flutter/material.dart';
import 'package:invest_management/model/category.dart';

abstract class CategoryState {
  const CategoryState();
}

class GetCategorySuccess extends CategoryState{
  final List<Category> listCategory;
  const GetCategorySuccess({@required this.listCategory});
}

class GetCategoryFailure extends CategoryState{}

