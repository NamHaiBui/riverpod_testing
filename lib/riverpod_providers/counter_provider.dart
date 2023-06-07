import 'package:hooks_riverpod/hooks_riverpod.dart';

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class CounterNotifier extends StateNotifier<int?> {
  CounterNotifier() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
  int? get value => state;
}

final counterProvider =
    StateNotifierProvider<CounterNotifier, int?>((ref) => CounterNotifier());
