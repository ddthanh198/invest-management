import 'package:invest_management/data/model/asset.dart';

class AddAssetEvent{}

class SaveAssetEvent extends AddAssetEvent {
  Asset asset;
  SaveAssetEvent(this.asset);
}

class UpdateAssetEvent extends AddAssetEvent {
  Asset asset;
  UpdateAssetEvent(this.asset);
}

class ValidateDataAssetEvent extends AddAssetEvent{
  String name;
  String capital;
  String profit;
  String profitPercent;

  ValidateDataAssetEvent(this.name, this.capital, this.profit, this.profitPercent);
}