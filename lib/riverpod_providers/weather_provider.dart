import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City {
  stockholm,
  paris,
  tokyo,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockholm: 'snow',
      City.paris: 'rain',
      City.tokyo: 'sunny'
    }[city]!,
  );
}

const unknownWeatherEmoji = 'Unknown';
// will be changed by the UI
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknownWeatherEmoji;
  }
});
