import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final tempUserProvider = StateProvider.autoDispose<User?>((ref) => null);
