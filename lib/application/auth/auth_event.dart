part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthWithFirebase extends AuthEvent {
  final String email;
  final String password;

  AuthWithFirebase(this.email, this.password);
}
