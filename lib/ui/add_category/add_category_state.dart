import 'package:flutter/material.dart';

class AddCategoryState {
  const AddCategoryState();
}

class PickColorSuccess extends AddCategoryState {
  final String? color;
  const PickColorSuccess(this.color);
}

class PickColorFailure extends AddCategoryState{}

class PickImageSuccess extends AddCategoryState {
  final String? imagePath;
  const PickImageSuccess({@required this.imagePath});
}

class PickImageFailure extends AddCategoryState {}

class SaveCategorySuccess extends AddCategoryState {}
class SaveCategoryFailure extends AddCategoryState {}
