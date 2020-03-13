import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {
  final userId;
  AuthAuthenticated(this.userId);

  @override
  List<Object> get props => [this.userId];
}

class AuthUnauthenticated extends AuthState {}
