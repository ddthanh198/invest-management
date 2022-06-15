import 'package:invest_management/data/network/model/user/list_user_response.dart';

abstract class UserState {}

class GetUsersSuccess extends UserState{
  List<User> listUser;
  GetUsersSuccess(this.listUser);
}

class GetUserFailure extends UserState{}