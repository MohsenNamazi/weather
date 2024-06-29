import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/network/open_weather/open_weather_network.dart';
import 'package:weather/data/repository/open_weather_repo.dart';

import '../../../mocks/dio_mock.dart';
import '../../model/file_loader.dart';

class MockDio extends Mock implements Dio {}

class FakeDioResponse extends Fake implements Response {
  @override
  final Map<String, dynamic>? data;

  FakeDioResponse({this.data});
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeDioResponse());
  });

  group('OpenWeatherNetwork', () {
    test('returns WeatherModel on successful get5dayForecast call', () async {
      final response =
          await FileLoader().loadFile('test/assets/five_days_weather.json');

      Dio dio = DioMock().mockData('/data/2.5/forecast', response);

      final openWeatherNetwork = OpenWeatherNetwork(dio);

      final weatherModel = WeatherModel.fromJson(response);

      final result = await openWeatherNetwork.get5dayForecast(
        lat: 52.5200,
        lon: 13.4050,
        unit: Units.metric,
      );

      expect(result, equals(weatherModel));
    });

    test('throws DioError on unsuccessful get5dayForecast call', () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/data/2.5/forecast'),
        response: Response(
          requestOptions: RequestOptions(path: '/data/2.5/forecast'),
          statusCode: 404,
        ),
      );

      Dio dio = DioMock().mockError('/data/2.5/forecast', exception);

      final openWeatherNetwork = OpenWeatherNetwork(dio);

      expect(
        () async => await openWeatherNetwork.get5dayForecast(
          lat: 52.5200,
          lon: 13.4050,
          unit: Units.metric,
        ),
        throwsA(isA<DioException>()),
      );
    });
  });
}
