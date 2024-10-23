part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

///Log in
class LoginLoadingState extends AuthState {}

class LoggedInState extends AuthState {
  final UserCredential userCredential;

  LoggedInState(this.userCredential);
}

class LoginErrorState extends AuthState {}

///Register
class RegisterLoadingState extends AuthState {}

class UserRegisterSuccessState extends AuthState {
  final UserCredential userCredential;

  UserRegisterSuccessState(this.userCredential);
}

class UserRegisterFailureState extends AuthState {}
