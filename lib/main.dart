import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const RollcallApp());

class RollcallApp extends StatelessWidget {
  const RollcallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rollcall',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
    );
  }
}
