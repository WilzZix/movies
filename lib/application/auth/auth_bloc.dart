import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/datasources/network_data_source/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthWithFirebase>(_authWithFireBase);
  }

  FirebaseAuthRepository repository = FirebaseAuthRepository();

  Future<void> _authWithFireBase(
      AuthWithFirebase event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoadingState());
      UserCredential userCredential =
          await repository.login(email: event.email, password: event.password);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      emit(LoggedInState(userCredential));
    } catch (e) {
      emit(LoginErrorState());
    }
  }
}
