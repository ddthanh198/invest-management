import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/blocs/asset_bloc_observer.dart';
import 'package:invest_management/data/db/database.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_screen.dart';
import 'ui/home/home_event.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AssetBlocObserver();
  AssetDatabase? assetDb = await $FloorAssetDatabase.databaseBuilder('asset_database.db').build();
  AssetRepository _repository = AssetRepository(assetDatabase: assetDb);
  runApp(MyApp(assetDatabase: assetDb, repository: _repository));
}

class MyApp extends StatelessWidget {

  final AssetDatabase? assetDatabase;
  final AssetRepository? repository;
  const MyApp({@required this.assetDatabase, @required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(repository: repository)
                                ..add(GetDataAssetEvent()),
        child: HomeScreen(repository: repository,),
      )
    );
  }
}