import 'package:flutter/material.dart';
import 'package:movies/core/utils/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  static String tag = '/';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tabletBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login on your account'),
            const SizedBox(
              height: 16,
            ),
            const TextField(),
            const SizedBox(
              height: 16,
            ),
            const TextField(),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: const BoxDecoration(color: Colors.blue),
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
