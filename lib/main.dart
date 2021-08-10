import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/root_screen_builder.dart';
import 'package:pragmatic_todo/ui/auth/login_view.dart';
import 'package:pragmatic_todo/ui/home/home_view.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter.instance;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _appRouter.navigationKey,
      routes: _appRouter.getRoutes(),
      home: RootViewBuilder(
        loggedInBuilder: (_) => const HomeView(),
        loggedOutBuilder: (_) => const LoginView(),
      ),
    );
  }
}
