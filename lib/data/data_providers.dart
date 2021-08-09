import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/shared_preferences_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
    (ref) => UserRepository(SharedPreferencesService.instance));

final currentUserProvider =
    StateProvider.autoDispose<User>((ref) => const User.loggedOut());
