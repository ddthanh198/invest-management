import 'package:flutter/material.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/data/model/pair.dart';
import 'package:invest_management/data/model/pie_data.dart';
import 'package:invest_management/data/model/triple.dart';

abstract class HomeState {}

class GetDataAssetSuccess extends HomeState {
  List<Category>? listCategory;
  List<PieData>? listPieData;
  Triple<int, int, double>? totalDataTriple;
  GetDataAssetSuccess({required this.listCategory, required this.listPieData, required this.totalDataTriple});
}

class GetDataAssetFailure extends HomeState{}

class DeleteCategorySuccess extends HomeState{}
class DeleteCategoryFailure extends HomeState{}

class DeleteAssetSuccess extends HomeState{}
class DeleteAssetFailure extends HomeState{}

class ExportAssetSuccess extends HomeState{}
class ExportAssetFailure extends HomeState{
  String? title;
  String? content;
  ExportAssetFailure({this.title, this.content});
}

class GetExportedFileSuccess extends HomeState{
  List<Pair<String, String>> listPath;
  GetExportedFileSuccess({required this.listPath});
}
class GetExportedFileFailure extends HomeState{
  String? title;
  String? content;
  GetExportedFileFailure({this.title, this.content});
}

class ImportAssetSuccess extends HomeState{

}
class ImportAssetFailure extends HomeState{
  String? title;
  String? content;
  ImportAssetFailure({this.title, this.content});
}