part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoggedInState extends AuthState {
  final UserCredential userCredential;

  LoggedInState(this.userCredential);
}

class LoginErrorState extends AuthState {}
