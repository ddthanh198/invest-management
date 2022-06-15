import 'package:package_info/package_info.dart';

import '../injection/injection.dart';

class AppModule extends DIModule {
  @override
  Future<void> provides() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    getIt.registerSingleton(packageInfo);
  }
}