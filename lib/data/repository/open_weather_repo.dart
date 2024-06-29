import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/open_weather/open_weather_network.dart';
import 'package:weather/data/service/geo_locator.dart';

enum Units {
  metric('metric'),
  imperial('imperial');

  const Units(this.name);
  final String name;
}

extension UnitSym on Units {
  String get sym => switch (this) {
        Units.imperial => '\u2109',
        Units.metric => '\u2103',
      };
}

class OpenWeatherRepo {
  OpenWeatherRepo(this._openWeather);
  final OpenWeatherNetwork _openWeather;

  Future<WeatherModel> getFivedayForecast({
    required UserLocation userLocation,
    required Units unit,
  }) async {
    return await _openWeather.get5dayForecast(
      lat: userLocation.lat,
      lon: userLocation.lon,
      unit: unit,
    );
  }
}
