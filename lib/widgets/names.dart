import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_testing/riverpod_providers/stream_provider.dart';

class Names extends ConsumerWidget {
  const Names({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return names.when(
        data: (data) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (ctx, index) => ListTile(
              title: Text(
                data.elementAt(index),
              ),
            ),
            itemCount: data.length,
          );
        },
        error: (_, __) =>
            const Text('You have reached the end of the list of names!'),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
