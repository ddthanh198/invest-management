import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/data/db/asset_dao.dart';
import 'package:invest_management/data/db/database.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/home/home_bloc.dart';
import 'package:invest_management/ui/home/home_screen.dart';
import 'package:package_info/package_info.dart';
import 'configurations/configurations.dart';
import 'configurations/env.dart';
import 'di/injection/injection.dart';
import 'ui/home/home_event.dart';

Future<void> main() async {
  Configurations().setConfigurationValues(environment);
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AssetBlocObserver();


  await Injection.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc()..add(GetDataAssetEvent()),
      child: MaterialApp(
          title: 'Quản lý đầu tư',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen()
      ),
    );
  }
}