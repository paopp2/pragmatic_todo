import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';
import 'package:pragmatic_todo/root_view_builder.dart';
import 'package:pragmatic_todo/ui/auth/login_view.dart';
import 'package:pragmatic_todo/ui/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? currentUsername = await AuthService.getCurrentUser();
  final sharedPrefsHelper = SharedPreferencesHelper.instance;
  final userRepository = UserRepository(sharedPrefsHelper);
  User? currentUser;
  if (currentUsername != null) {
    currentUser = await userRepository.getUser(currentUsername);
  }
  runApp(
    ProviderScope(
      overrides: [
        currentUserProvider.overrideWithProvider(
            StateProvider.autoDispose((ref) => currentUser))
      ],
      child: const MyApp(),
    ),
  );
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
