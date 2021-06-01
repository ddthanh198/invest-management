import 'package:invest_management/data/db/asset_dao.dart';
import 'package:invest_management/data/model/asset.dart';
import 'package:invest_management/data/model/category.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 2, entities: [Asset, Category])
abstract class AssetDatabase extends FloorDatabase {
  AssetDao get assetDao;
}