import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/auth_bloc/auth_event.dart';
import 'package:friendlychat/blocs/auth_bloc/auth_state.dart';
import 'package:user_repository/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        this._userRepository = userRepository;

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    print("auth event");
    if (event is AppStarted) {
      try {
        final isAuth = await _userRepository.isAuthenticated();
        if (!isAuth) {
          await _userRepository.authenticate();
        }
        final userId = await _userRepository.getUserId();
        yield AuthAuthenticated(userId);
      } catch (err) {
        print('In bloc error: $err');
        print(err.message);

        yield AuthUnauthenticated();
      }
    }
  }
}
