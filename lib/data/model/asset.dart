import 'package:floor/floor.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

@JsonSerializable()
@Entity(
  tableName: 'asset',
  foreignKeys: [
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: Category,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade,
    )
  ],
)
class Asset {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'category_id') int? categoryId;
  @ColumnInfo(name: 'name') String? name;
  @ColumnInfo(name: 'capital') int? capital = 0;
  @ColumnInfo(name: 'profit') int? profit = 0;
  @ColumnInfo(name: 'profitPercent') double? profitPercent = 0;

  Asset(this.id, this.categoryId, this.name, this.capital, this.profit, this.profitPercent);

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}