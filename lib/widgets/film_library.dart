import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../riverpod_providers/favorite_provider.dart';

class FilmLibrary extends ConsumerWidget {
  const FilmLibrary({required this.provider, super.key});

  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
        child: ListView.builder(
      itemBuilder: (ctx, index) {
        final film = films.elementAt(index);

        final favoriteIcon = film.isFavorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border);
        return ListTile(
          title: Text(film.title),
          subtitle: Text(film.description),
          trailing: IconButton(
            icon: favoriteIcon,
            onPressed: () {
              final isFavorite = !film.isFavorite;
              ref.read(allFilmsProvider.notifier).update(film, isFavorite);
            },
          ),
        );
      },
      itemCount: films.length,
    ));
  }
}

class FilterWidget extends ConsumerWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      return DropdownButton(
        value: ref.watch(favoriteStatusProvider),
        items: FavoriteStatus.values
            .map((e) => DropdownMenuItem(
                value: e, child: Text(e.toString().split('.').last)))
            .toList(),
        onChanged: (value) {
          ref.read(favoriteStatusProvider.notifier).state = value!;
        },
      );
    });
  }
}
