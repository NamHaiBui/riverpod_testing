import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_testing/riverpod_providers/counter_provider.dart';

class Counter1 extends ConsumerWidget {
  const Counter1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            final text = count == null ? ' Press the button' : count.toString();
            return Text(text);
          },
        ),
        TextButton(
          onPressed: () {
            ref.read(counterProvider.notifier).increment();
          },
          child: const Text('Increment counter'),
        ),
      ],
    );
  }
}
