import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/data/service/geo_locator.dart';
import 'package:weather/feature/weather/cubit/weather_screen_cubit.dart';

import '../../../data/model/weather_model.dart';
import '../../../mocks/open_weather_repo_mock.dart';

void main() {
  late WeatherScreenCubit cubit;
  late OpenWeatherRepoMock openWeatherRepoMock;
  late WeatherModel weatherModel;

  final berlinLocation = UserLocation(lat: 52.5200, lon: 13.4050);
  const unit = Units.metric;

  setUp(() async {
    openWeatherRepoMock = OpenWeatherRepoMock();
    cubit = WeatherScreenCubit(repository: openWeatherRepoMock);
    weatherModel = await WeatherModelFake.getData;
  });

  tearDown(() {
    cubit.close();
  });

  // Test for successful weather data loading
  blocTest<WeatherScreenCubit, WeatherScreenState>(
    'emit weatherModel by loading the weather',
    setUp: () {
      // Mock successful response
      when(() => openWeatherRepoMock.getFivedayForecast(
          userLocation: berlinLocation,
          unit: unit)).thenAnswer((_) async => weatherModel);
    },
    build: () => cubit,
    act: (cubit) => cubit.loadWeather(unit: unit, userLocation: berlinLocation),
    expect: () => [
      const WeatherScreenState.loading(),
      WeatherScreenState.data(weatherModel)
    ],
    verify: (bloc) {
      // Verify method call
      verify(() => openWeatherRepoMock.getFivedayForecast(
          userLocation: berlinLocation, unit: unit)).called(1);
    },
  );

  // Test for error state when exception is thrown
  blocTest<WeatherScreenCubit, WeatherScreenState>(
    'emit the error state',
    setUp: () {
      // Mock exception
      when(() => openWeatherRepoMock.getFivedayForecast(
          userLocation: berlinLocation,
          unit: unit)).thenThrow(Exception('Test exception'));
    },
    build: () => cubit,
    act: (cubit) => cubit.loadWeather(unit: unit),
    verify: (bloc) {
      final isError = bloc.state.whenOrNull(error: (_, __) => true);
      expect(isError, true);
    },
  );
}
