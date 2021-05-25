import 'package:floor/floor.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';

@dao
abstract class AssetDao {
  @Query('SELECT * FROM category')
  Future<List<Category>> findAllCategories();

  @Query('SELECT * FROM asset WHERE category_id = :categoryId')
  Future<List<Asset>> findAllAssetWithCategoryId(int categoryId);

  @insert
  Future<void> insertCategory(Category category);

  @insert
  Future<void> insertAsset(Asset asset);
}