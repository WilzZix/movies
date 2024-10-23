import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class OAuthExample extends StatefulWidget {
  static String tag = '/oauth';

  @override
  _OAuthExampleState createState() => _OAuthExampleState();
}

class _OAuthExampleState extends State<OAuthExample> {
  String apiKey = '';

  Future<void> authenticate() async {
    const clientId = '9eb3a3779d0206d18a39ac0f045f11c2';
    const redirectUri = 'your.app://callback';
    const url =
        'https://www.themoviedb.org/authenticate/{request_token}?redirect_to=$redirectUri';

    // Step 1: Get a request token
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/authentication/token/new?api_key=$clientId'),
    );
    log('line 29 ${response.body}');
    final requestToken = json.decode(response.body)['request_token'];

    // Step 2: Redirect to TMDB for authentication
    final result = await FlutterWebAuth.authenticate(
      url:
          'https://www.themoviedb.org/authenticate/$requestToken?redirect_to=$redirectUri',
      callbackUrlScheme: 'your.app',
    );

    log('line 39 ${result}');
    final token = Uri.parse(result).queryParameters['request_token'];
    log('line 41 ${token}');
    // Step 3: Convert the request token to an access token
    final sessionResponse = await http.post(
      Uri.parse(
          'https://api.themoviedb.org/3/authentication/session/new?api_key=$clientId'),
      body: json.encode({'request_token': token}),
      headers: {'Content-Type': 'application/json'},
    );

    apiKey = json.decode(sessionResponse.body)['session_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: authenticate,
          child: const Text('Authenticate with TMDB'),
        ),
        if (apiKey.isNotEmpty) Text('API Key: $apiKey'),
      ],
    );
  }
}
