import 'package:floor/floor.dart';
import 'package:invest_management/data/model/category.dart';

@dao
abstract class AssetDao {
  @Query('SELECT * FROM category')
  Future<List<Category>> findAllCategories();

  @insert
  Future<void> insertCategory(Category category);
}