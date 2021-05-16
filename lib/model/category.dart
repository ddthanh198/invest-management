import 'package:invest_management/model/asset.dart';

class Category {
  String name;
  String image;
  String color;
  List<Asset> assets = List.empty(growable: true);

  Category({this.name, this.image, this.color});
}