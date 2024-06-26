import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/open_weather/open_weather_network.dart';

class OpenWeatherRepo {
  OpenWeatherRepo(this._openWeather);
  final OpenWeatherNetwork _openWeather;

  Future<WeatherModel> get5dayForecast(
      {required String latitude, required String longitude}) async {
    return await _openWeather.get5dayForecast(lat: latitude, lon: longitude);
  }
}
