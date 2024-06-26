import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/open_weather/open_weather_network.dart';
import 'package:weather/data/service/geo_locator.dart';

class OpenWeatherRepo {
  OpenWeatherRepo(this._openWeather);
  final OpenWeatherNetwork _openWeather;

  Future<WeatherModel> get5dayForecast(
      {required UserLocation userLocation}) async {
    return await _openWeather.get5dayForecast(
      lat: userLocation.lat,
      lon: userLocation.lon,
    );
  }
}
