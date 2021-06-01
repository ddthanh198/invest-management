import 'package:floor/floor.dart';
import 'package:invest_management/data/model/asset.dart';

@Entity(tableName: "category")
class Category {
  Category(this.id, this.name, this.image, this.color);

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'name') String? name;
  @ColumnInfo(name: 'image') String? image;
  @ColumnInfo(name: 'color') String? color;
  @ignore List<Asset> assets = List.empty(growable: true);
  @ignore int totalCapital = 0;
  @ignore int totalProfit = 0;
  @ignore double totalProfitPercent = 0;
}