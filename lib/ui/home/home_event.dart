
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';

abstract class HomeEvent {}

class GetDataAssetEvent extends HomeEvent{}

class DeleteCategoryEvent extends HomeEvent {
  Category category;
  DeleteCategoryEvent(this.category);
}

class DeleteAssetEvent extends HomeEvent {
  Asset asset;
  DeleteAssetEvent(this.asset);
}

class ExportAssetEvent extends HomeEvent {}
class GetExportedFileEvent extends HomeEvent {}
class ImportAssetEvent extends HomeEvent {
  String filePath;
  ImportAssetEvent(this.filePath);
}