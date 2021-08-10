import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/db_helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
    (ref) => UserRepository(SharedPreferencesHelper.instance));

final authStateProvider = StateNotifierProvider.autoDispose<AuthService, User>(
    (ref) => AuthService());
