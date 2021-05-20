import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';

class AddCategoryEvent{
  const AddCategoryEvent();
}

class PickColorEvent extends AddCategoryEvent {
  final String color;
  const PickColorEvent(this.color);
}
class PickImageEvent extends AddCategoryEvent {}
class SaveCategoryEvent extends AddCategoryEvent{
  final Category? category;

  const SaveCategoryEvent({@required this.category});
}