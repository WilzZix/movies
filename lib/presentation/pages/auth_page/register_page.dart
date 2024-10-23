import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/application/auth/auth_bloc.dart';
import 'package:movies/core/utils/colors.dart';
import 'package:movies/presentation/pages/home_page/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String tag = '/register-page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tabletBackground,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserRegisterSuccessState) {
            context.pushNamed(BottomNavigationPage.tag);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Register your account'),
              const SizedBox(
                height: 16,
              ),
              TextField(
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                controller: emailTextController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordTextController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    RegisterWithFirebase(
                        emailTextController.text, passwordTextController.text),
                  );
                },
                child: Center(
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
