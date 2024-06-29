import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/app_router.dart';
import 'package:weather/data/network/open_weather/open_weather_network.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/data/service/geo_locator.dart';
import 'package:weather/dependency_injector/injector.dart';
import 'package:weather/feature/weather/cubit/units_cubit.dart';
import 'package:weather/feature/weather/cubit/weather_screen_cubit.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const WeatherScreenState.loading());
  });

  setUp(() {
    GetIt.instance.reset();
  });

  group('Injector', () {
    test('should register and resolve dependencies', () {
      // Initialize the injector
      Injector.init();

      // Assert all dependencies are registered correctly
      expect(GetIt.instance<AppRouter>(), isA<AppRouter>());
      expect(GetIt.instance<Dio>(), isA<Dio>());
      expect(GetIt.instance<OpenWeatherNetwork>(), isA<OpenWeatherNetwork>());
      expect(GetIt.instance<OpenWeatherRepo>(), isA<OpenWeatherRepo>());
      expect(GetIt.instance<GeoLocator>(), isA<GeoLocator>());
      expect(GetIt.instance<WeatherScreenCubit>(), isA<WeatherScreenCubit>());
      expect(GetIt.instance<UnitsCubit>(), isA<UnitsCubit>());
    });
  });
}
