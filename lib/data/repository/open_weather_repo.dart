import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/open_weather/open_weather.dart';

class OpenWeatherRepo {
  OpenWeatherRepo(this._openWeather);
  final OpenWeather _openWeather;

  Future<WeatherModel> get5dayForecast(
      {String? latitude, String? longitude}) async {
    return await _openWeather.get5dayForecast(lat: latitude, lon: longitude);
  }
}
