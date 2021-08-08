import 'package:flutter/material.dart';
import 'package:pragmatic_todo/ui/auth/login_screen.dart';
import 'package:pragmatic_todo/ui/auth/register_screen.dart';
import 'package:pragmatic_todo/ui/home/home_screen.dart';

class AppRouter {
  final Map<String, Widget Function(BuildContext)> _routesList = {
    Routes.homeScreen: (context) => const HomeScreen(),
    Routes.loginScreen: (context) => const LoginScreen(),
    Routes.registerScreen: (context) => const RegisterScreen(),
  };

  Map<String, Widget Function(BuildContext)> getRoutes() => _routesList;

  static void gotoHomeScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routes.homeScreen);

  static void gotoLoginScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routes.loginScreen);

  static void gotoRegisterScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routes.registerScreen);
}

class Routes {
  static const homeScreen = '/home_screen';
  static const loginScreen = '/login_screen';
  static const registerScreen = '/register_screen';
}
