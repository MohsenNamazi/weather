import 'package:mocktail/mocktail.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/repository/open_weather_repo.dart';

class OpenWeatherRepoMock extends Mock implements OpenWeatherRepo {
  void mockGetFivedayForecast(WeatherModel expected) {
    when(
      () => getFivedayForecast(
        userLocation: any(named: 'userLocation'),
        unit: any(named: 'unit'),
      ),
    ).thenAnswer(
      (_) async => expected,
    );
  }
}
