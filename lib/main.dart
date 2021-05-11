import 'package:flutter/material.dart';
import 'package:invest_management/blocs/asset_bloc_observer.dart';
import 'package:invest_management/ui/HomeScreen.dart';
import 'package:bloc/bloc.dart';

void main() {
  Bloc.observer = AssetBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}