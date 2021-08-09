import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/home/home_controller.dart';

final homeControllerProvider =
    Provider.autoDispose<HomeController>((ref) => HomeController(ref.read));
