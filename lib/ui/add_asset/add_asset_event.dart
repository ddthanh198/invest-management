import 'package:invest_management/data/model/asset.dart';

class AddAssetEvent{}

class SaveAssetEvent extends AddAssetEvent {
  Asset asset;
  SaveAssetEvent(this.asset);
}