import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/blocs/asset_bloc_observer.dart';
import 'package:invest_management/blocs/home_bloc.dart';
import 'package:invest_management/repositories/asset_repository.dart';
import 'package:invest_management/ui/home_screen.dart';
import 'package:bloc/bloc.dart';

import 'events/home_event.dart';

void main() {
  Bloc.observer = AssetBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AssetRepository _repository = AssetRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(repository: _repository)
                                ..add(GetDataAssetEvent()),
        child: HomeScreen(repository: _repository,),
      )
    );
  }
}