part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithTMDB extends AuthEvent {}

class CheckUserLogInStatus extends AuthEvent {}
