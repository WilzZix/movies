import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/datasources/network_data_source/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInWithTMDB>(_signInTMDB);
    on<CheckUserLogInStatus>(_checkUserLoginStatus);
  }

  FirebaseAuthRepository repository = FirebaseAuthRepository();

  Future<void> _signInTMDB(
      SignInWithTMDB event, Emitter<AuthState> emit) async {
    const clientId = '26f62c7bb1573534f581d047e25069e8';
    const redirectUri = 'your.app://callback';
    try {
      emit(SingInProgressState());
      // Step 1: Get a request token
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/authentication/token/new?api_key=$clientId'),
      );

      final requestToken = json.decode(response.body)['request_token'];

      // Step 2: Redirect to TMDB for authentication
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://www.themoviedb.org/authenticate/$requestToken?redirect_to=$redirectUri',
        callbackUrlScheme: 'your.app',
      );

      final token = Uri.parse(result).queryParameters['request_token'];

      // Step 3: Convert the request token to an access token
      final sessionResponse = await http.post(
        Uri.parse(
            'https://api.themoviedb.org/3/authentication/session/new?api_key=$clientId'),
        body: json.encode({'request_token': token}),
        headers: {'Content-Type': 'application/json'},
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      prefs.setString(
          'sessionId', json.decode(sessionResponse.body)['session_id']);
      emit(SingInSuccessState(json.decode(sessionResponse.body)['session_id']));
    } catch (e) {
      emit(SignInFailureState(e.toString()));
    }
  }

  Future<void> _checkUserLoginStatus(
      CheckUserLogInStatus event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    emit(UserLoginStatus(prefs.getBool('auth') as bool));
  }
}
