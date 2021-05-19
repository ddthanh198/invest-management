import 'package:floor/floor.dart';
import 'package:invest_management/data/model/asset.dart';

@Entity(tableName: "category")
class Category {
  Category({this.name, this.image, this.color});

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'custom_name') String? name;
  @ColumnInfo(name: 'image') String? image;
  @ColumnInfo(name: 'color') String? color;
  @ignore List<Asset> assets = List.empty(growable: true);
}