import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// State Notifier Provider
/// It holds a state object of any type and you will be allowed to change the object
/// of which the notifier will notify the listeners.
/// You don't have to notify the listeners manually like Change Notifier but instead,
/// it will be automactically notified by the State Notifier Provider.
///

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });
  Film copy({required bool isFavorite}) {
    return Film(
      id: id,
      description: description,
      title: title,
      isFavorite: isFavorite,
    );
  }

  @override
  String toString() {
    return 'Film(id: $id, title: $title, '
        'description: $description, '
        'isFavorite:$isFavorite)';
  }

  @override
  bool operator ==(covariant Film other) => id == other.id && other.isFavorite;

  @override
  int get hashCode => Object.hashAll([id, isFavorite]);
}

const List<Film> filmLib = [];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(filmLib);
  void update(Film film, bool isFavorite) {
    state = state
        .map(
          (film) =>
              film.id == film.id ? film.copy(isFavorite: isFavorite) : film,
        )
        .toList();
  }
}

enum FavoriteStatus { all, favorite, notFavorite }

final favoriteStatusProvider =
    StateProvider<FavoriteStatus>((ref) => FavoriteStatus.all);

final allFilmsProvider =
    StateNotifierProvider<FilmsNotifier, List<Film>>((ref) => FilmsNotifier());
final favoriteFilmsProvider = Provider<Iterable<Film>>(
    (ref) => ref.watch(allFilmsProvider).where((film) => film.isFavorite));
final nonfavoriteFilmsProvider = Provider<Iterable<Film>>(
    (ref) => ref.watch(allFilmsProvider).where((film) => !film.isFavorite));
