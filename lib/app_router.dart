import 'package:flutter/material.dart';
import 'package:pragmatic_todo/ui/auth/login_screen.dart';
import 'package:pragmatic_todo/ui/auth/register_screen.dart';
import 'package:pragmatic_todo/ui/home/home_screen.dart';

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routesList = {
    Routes.homeScreen: (context) => const HomeScreen(),
    Routes.loginScreen: (context) => const LoginScreen(),
    Routes.registerScreen: (context) => const RegisterScreen(),
  };

  Map<String, Widget Function(BuildContext)> getRoutes() => instance.routesList;

  Future<dynamic>? navigateToRegisterScreen() =>
      navigationKey.currentState?.pushNamed(Routes.registerScreen);

  Future<dynamic>? navigateToLoginScreen() =>
      navigationKey.currentState?.pushNamed(Routes.loginScreen);

  Future<dynamic>? navigateToHomeScreen() =>
      navigationKey.currentState?.pushNamed(Routes.homeScreen);

  void popScreen() {
    return navigationKey.currentState?.pop();
  }
}

class Routes {
  static const homeScreen = '/home_screen';
  static const loginScreen = '/login_screen';
  static const registerScreen = '/register_screen';
}
