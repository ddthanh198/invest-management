import 'package:flutter/material.dart';
import 'package:invest_management/data/db/asset_dao.dart';
import 'package:invest_management/data/db/database.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'package:invest_management/utils/ResourceUtils.dart';

class AssetRepository {
  final AssetDao? assetDao;

  const AssetRepository({@required this.assetDao});

  Future<List<Category>?> getDataAsset() async {
    List<Category> categories = await assetDao!.findAllCategories();
    return assetDao!.findAllCategories();

  }

  Future<List<Asset>> getAssetsWithCategoryId(int categoryId) async {
    return assetDao!.findAllAssetWithCategoryId(categoryId);
  }

  Future<List<Category>?> getCategory() async {
    return assetDao!.findAllCategories();
  }

  Future<void> saveCategory(Category category) async {
    return assetDao!.insertCategory(category);
  }

  Future<void> saveAsset(Asset asset) async {
    return assetDao!.insertAsset(asset);
  }

  Future<void> updateAsset(Asset asset) async {
    return assetDao!.updateAsset(asset);
  }

  Future<void> updateCategory(Category category) async {
    return assetDao!.updateCategory(category);
  }

  Future<void>deleteAsset(Asset asset) async {
    return assetDao!.deleteAsset(asset);
  }

  Future<void> deleteCategory(Category category) async {
    return assetDao!.deleteCategory(category);
  }

  Future<void> deleteAllAssetWithCategory(int categoryId) async {
    return assetDao!.deleteAllAssetWithCategoryId(categoryId);
  }

  Future<void> deleteAllAsset() async {
    return assetDao!.deleteAllAsset();
  }
}