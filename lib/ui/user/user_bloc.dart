import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_management/di/injection/injection.dart';
import 'package:invest_management/repositories/user_repository.dart';
import 'package:invest_management/ui/user/user_event.dart';
import 'package:invest_management/ui/user/user_state.dart';

import '../../data/network/model/user/list_user_response.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository repository = getIt<UserRepository>();

  UserBloc() : super(GetUsersSuccess(List.empty(growable: true))){
    on<GetUserEvent>((event, emit) => _handleGetUserEvent(event, emit));
  }

  void _handleGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    try {
      var queries = {
        "page": 1,
        "results": 20
      };

      ListUserResponse response = await repository.getUsers(queries);
      List<User>? users = response.results;

      emit(GetUsersSuccess(users!));
    } catch(exception) {
      print(exception);
      emit(GetUserFailure());
    }
  }
}