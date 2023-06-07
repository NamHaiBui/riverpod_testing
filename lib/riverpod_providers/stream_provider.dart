import 'package:hooks_riverpod/hooks_riverpod.dart';

const names = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry'
];
final tickerProvider = StreamProvider((ref) => Stream.periodic(
      const Duration(seconds: 1),
      (i) => i + 1,
    ));
final namesProvider = StreamProvider(
    (ref) => ref.watch(tickerProvider.stream).map((count) => names.getRange(
          0,
          count,
        )));
