import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/auth/auth_controller.dart';
import 'package:pragmatic_todo/model/user/user.dart';

/// Provider of AuthController instance
final authControllerProvider =
    Provider.autoDispose<AuthController>((ref) => AuthController(ref.read));

/// Provider used for when checking if some user exists
final someUserProvider = StateProvider.autoDispose<User?>((ref) => null);
