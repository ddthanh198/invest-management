import 'package:invest_management/data/network/config/dio_client.dart';
import 'package:invest_management/di/injection/injection.dart';

import '../../data/network/service/user_service.dart';

class NetworkModule extends DIModule {
  @override
  Future<void> provides() async {
    final dio = await DioClient.setup();

    getIt.registerSingleton(dio);
    getIt.registerSingleton(UserService(dio, baseUrl: dio.options.baseUrl));
  }
}
