import 'package:get_it/get_it.dart';
import 'package:invest_management/di/module/app_module.dart';
import 'package:invest_management/di/module/repository_module.dart';

import '../module/network_module.dart';



GetIt getIt = GetIt.instance;

abstract class DIModule {
  void provides();
}

class Injection {
  static Future<void> inject() async {
    await AppModule().provides();
    await NetworkModule().provides();
    await RepositoryModule().provides();
  }
}
