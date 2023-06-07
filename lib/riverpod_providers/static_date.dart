// This does not refresh. This just gets a value and be happy with it
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentDate = Provider(
  (ref) => DateTime.now(),
);
