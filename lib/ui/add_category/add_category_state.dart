import 'package:flutter/material.dart';

class AddCategoryState {}

class PickColorSuccess extends AddCategoryState {
  String? color;
  PickColorSuccess(this.color);
}

class PickColorFailure extends AddCategoryState{}

class PickImageSuccess extends AddCategoryState {
  String? imagePath;
  PickImageSuccess({@required this.imagePath});
}

class PickImageFailure extends AddCategoryState {}

class SaveCategorySuccess extends AddCategoryState {}
class SaveCategoryFailure extends AddCategoryState {}
