import 'package:invest_management/data/network/service/user_service.dart';
import 'package:invest_management/di/injection/injection.dart';

import '../data/network/model/user/list_user_response.dart';

class UserRepository {
  final userService = getIt.get<UserService>();

  Future<ListUserResponse> getUsers(Map<String, dynamic> queries) {
    return userService.getUsers(queries);
  }
}