import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/application/auth/auth_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckUserLogInStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SingInSuccessState) {
          loggedIn = true;
          setState(() {});
        }
        if (state is UserLoginStatus) {
          loggedIn = state.loggedIn;
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(SignInWithTMDB());
          },
          child: Center(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                shape: BoxShape.rectangle,
                color: Colors.blue,
              ),
              child: Center(
                child: !loggedIn
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Sign in with TMDB',
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.network(
                              'https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_1-5bdc75aaebeb75dc7ae79426ddd9be3b2be1e342510f8202baf6bffa71d7f5c4.svg',
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'Log out',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
