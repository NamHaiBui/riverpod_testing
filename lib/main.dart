import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_testing/riverpod_providers/favorite_provider.dart';
import 'package:riverpod_testing/widgets/film_library.dart';

void main(List<String> args) {
  runApp(ProviderScope(
    child: MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  ));
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Hooks Riverpod')),
        body: Column(
          children: [
            const FilterWidget(),
            Consumer(
              builder: (context, ref, child) {
                final filter = ref.watch(favoriteStatusProvider);
                switch (filter) {
                  case FavoriteStatus.all:
                    return FilmLibrary(provider: allFilmsProvider);
                  case FavoriteStatus.favorite:
                    return FilmLibrary(provider: favoriteFilmsProvider);
                  case FavoriteStatus.notFavorite:
                    return FilmLibrary(provider: nonfavoriteFilmsProvider);
                }
              },
            )
          ],
        ));
  }
}
