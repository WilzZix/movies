part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthWithFirebase extends AuthEvent {
  final String email;
  final String password;

  AuthWithFirebase(this.email, this.password);
}

class RegisterWithFirebase extends AuthEvent {
  final String email;
  final String password;

  RegisterWithFirebase(this.email, this.password);
}

class SigninWithTMDB extends AuthEvent {

}
