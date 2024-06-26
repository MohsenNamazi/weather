import 'package:dio/dio.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/dio/dio_request.dart';

class OpenWeather extends DioRequest {
  OpenWeather(Dio dio) : super(dio, 'https://api.openweathermap.org');

  // The API key just covers the free plan
  final apiKey = 'b769f316d6618f4745debdeffe210f47';

  Future<WeatherModel> get5dayForecast({String? lat, String? lon}) async {
    final queryParameters = <String, dynamic>{
      'lat': lat,
      'lon': lon,
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
