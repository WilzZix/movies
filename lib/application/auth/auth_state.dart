part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

///Sign in with TMDB
class SingInProgressState extends AuthState {}

class SingInSuccessState extends AuthState {
  final String apiKay;

  SingInSuccessState(this.apiKay);
}

class SignInFailureState extends AuthState {
  final String msg;

  SignInFailureState(this.msg);
}

///
class UserLoginStatus extends AuthState {
  final bool loggedIn;

  UserLoginStatus(this.loggedIn);
}
