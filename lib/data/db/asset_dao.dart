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

  @update
  Future<void> updateCategory(Category category);

  @update
  Future<void> updateAsset(Asset asset);

  @delete
  Future<void> deleteCategory(Category category);

  @delete
  Future<void> deleteAsset(Asset asset);

  @Query('DELETE FROM asset WHERE category_id = :categoryId')
  Future<void> deleteAllAssetWithCategoryId(int categoryId);
}