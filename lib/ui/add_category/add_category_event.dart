import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';

class AddCategoryEvent{}

class PickColorEvent extends AddCategoryEvent {
  String color;
  PickColorEvent(this.color);
}
class PickImageEvent extends AddCategoryEvent {}
class SaveCategoryEvent extends AddCategoryEvent{
  Category? category;
  SaveCategoryEvent({@required this.category});
}