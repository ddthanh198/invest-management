import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/blocs/asset_bloc_observer.dart';
import 'package:invest_management/data/db/asset_dao.dart';
import 'package:invest_management/data/db/database.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_screen.dart';
import 'package:package_info/package_info.dart';
import 'ui/home/home_event.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AssetBlocObserver();

  final migration1to2 = Migration(1, 2, (database) async {
    await database.execute('ALTER TABLE asset MODIFY COLUMN profitPercent REAL');
  });

  AssetDatabase? assetDb = await $FloorAssetDatabase.databaseBuilder('asset_database.db').addMigrations([migration1to2]).build();
  AssetDao assetDao = assetDb.assetDao;
  AssetRepository _repository = AssetRepository(assetDao: assetDao);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  runApp(MyApp(assetDatabase: assetDb, repository: _repository, packageInfo: packageInfo));
}

class MyApp extends StatelessWidget {

  final AssetDatabase? assetDatabase;
  final AssetRepository repository;
  final PackageInfo packageInfo;
  const MyApp({required this.assetDatabase, required this.repository, required this.packageInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(repository: repository)..add(GetDataAssetEvent()),
      child: MaterialApp(
          title: 'Quản lý đầu tư',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(repository: repository, packageInfo: packageInfo,)
      ),
    );
  }
}