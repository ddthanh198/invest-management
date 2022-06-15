import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/user/list_user_response.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET('api')
  Future<ListUserResponse> getUsers(@Queries() Map<String, dynamic> queries);
}