import 'package:dio/dio.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/dio/dio_request.dart';
import 'package:weather/data/repository/open_weather_repo.dart';

class OpenWeatherNetwork extends DioRequest {
  OpenWeatherNetwork(Dio dio) : super(dio, 'https://api.openweathermap.org');

  // The API key just covers the free plan
  final apiKey = 'b769f316d6618f4745debdeffe210f47';

  Future<WeatherModel> getFivedayForecast({
    required double lat,
    required double lon,
    required Units unit,
  }) async {
    final queryParameters = <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'units': unit.name,
      'appid': apiKey,
    }..removeWhere((k, v) => v == null);
    final result = await setDioRequest(
      url: '/data/2.5/forecast',
      contentType: 'multipart/form-data',
      method: RequestMethod.get,
      queryParameters: queryParameters,
    );
    final value = WeatherModel.fromJson(result.data!);
    return value;
  }
}
