import 'package:floor/floor.dart';
import 'package:invest_management/data/model/category.dart';

@Entity(
  tableName: 'asset',
  foreignKeys: [
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: Category,
    )
  ],
)
class Asset {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'category_id') int? categoryId;
  @ColumnInfo(name: 'name') String? name;
  @ColumnInfo(name: 'capital') int? capital;
  @ColumnInfo(name: 'profit') int? profit;
  @ColumnInfo(name: 'profitPercent') int? profitPercent;

  Asset(this.id, this.categoryId, this.name, this.capital, this.profit, this.profitPercent);
}