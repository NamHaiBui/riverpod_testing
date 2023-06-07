import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_testing/riverpod_providers/static_date.dart';

class RiverpodStaticProvider extends ConsumerWidget {
  const RiverpodStaticProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Everytime the provider changes the output value, the build function will be caled again
    final date = ref.watch(currentDate);
    return Center(child: Text(date.toIso8601String()));
  }
}
