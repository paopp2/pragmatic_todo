import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';

final authServiceProvider =
    Provider.autoDispose<AuthService>((ref) => AuthService(ref.read));
