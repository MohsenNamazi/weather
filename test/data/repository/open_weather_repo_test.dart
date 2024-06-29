import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/data/service/geo_locator.dart';

import '../../mocks/open_weather_network_mock.dart';
import '../model/weather_model.dart';

void main() {
  late MockOpenWeatherNetwork mockOpenWeatherNetwork;
  late OpenWeatherRepo openWeatherRepo;
  late WeatherModel weatherModel;

  setUp(() async {
    mockOpenWeatherNetwork = MockOpenWeatherNetwork();
    openWeatherRepo = OpenWeatherRepo(mockOpenWeatherNetwork);
    weatherModel = await WeatherModelFake.getData();
  });

  group('OpenWeatherRepo', () {
    final userLocation = UserLocation(lat: 52.5200, lon: 13.4050);
    const unit = Units.metric;

    test('returns WeatherModel on successful getFivedayForecast call',
        () async {
      // Arrange
      when(() => mockOpenWeatherNetwork.getFivedayForecast(
            lat: userLocation.lat,
            lon: userLocation.lon,
            unit: unit,
          )).thenAnswer((_) async => weatherModel);

      // Act
      final result = await openWeatherRepo.getFivedayForecast(
        userLocation: userLocation,
        unit: unit,
      );

      // Assert
      expect(result, equals(weatherModel));
      verify(() => mockOpenWeatherNetwork.getFivedayForecast(
            lat: userLocation.lat,
            lon: userLocation.lon,
            unit: unit,
          )).called(1);
    });

    test('throws Exception on unsuccessful getFivedayForecast call', () async {
      // Arrange
      final exception = Exception('Network error');
      when(() => mockOpenWeatherNetwork.getFivedayForecast(
            lat: userLocation.lat,
            lon: userLocation.lon,
            unit: unit,
          )).thenThrow(exception);

      // Act & Assert
      expect(
        () async => await openWeatherRepo.getFivedayForecast(
          userLocation: userLocation,
          unit: unit,
        ),
        throwsA(equals(exception)),
      );
      verify(() => mockOpenWeatherNetwork.getFivedayForecast(
            lat: userLocation.lat,
            lon: userLocation.lon,
            unit: unit,
          )).called(1);
    });
  });
}
