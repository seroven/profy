import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String routeName = 'auth';
  static const String routePath = '/auth';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Auth screen'),
      ),
    );
  }
}
