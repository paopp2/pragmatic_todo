import 'package:flutter/material.dart';
import 'package:pragmatic_todo/ui/auth/login_view.dart';
import 'package:pragmatic_todo/ui/auth/register_view.dart';
import 'package:pragmatic_todo/ui/home/home_view.dart';
import 'package:pragmatic_todo/ui/todo/todo_view.dart';

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routesList = {
    Routes.homeView: (context) => const HomeView(),
    Routes.loginView: (context) => const LoginView(),
    Routes.registerView: (context) => const RegisterView(),
    Routes.todoView: (context) => const TodoView(),
  };

  Map<String, Widget Function(BuildContext)> getRoutes() => instance.routesList;

  Future<dynamic>? navigateToRegisterView() =>
      navigationKey.currentState?.pushNamed(Routes.registerView);

  Future<dynamic>? navigateToLoginView() =>
      navigationKey.currentState?.pushNamed(Routes.loginView);

  Future<dynamic>? navigateToHomeView() =>
      navigationKey.currentState?.pushNamed(Routes.homeView);

  Future<dynamic>? navigateToTodoView() =>
      navigationKey.currentState?.pushNamed(Routes.todoView);

  void popView() {
    return navigationKey.currentState?.pop();
  }
}

class Routes {
  static const homeView = '/home_view';
  static const loginView = '/login_view';
  static const registerView = '/register_view';
  static const todoView = '/todo_view';
}
