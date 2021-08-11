import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers/current_user_provider.dart';

class RootViewBuilder extends HookConsumerWidget {
  const RootViewBuilder({
    Key? key,
    required this.loggedOutBuilder,
    required this.loggedInBuilder,
  }) : super(key: key);
  final WidgetBuilder loggedInBuilder;
  final WidgetBuilder loggedOutBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return (currentUser != null)
        ? loggedInBuilder(context)
        : loggedOutBuilder(context);
  }
}
