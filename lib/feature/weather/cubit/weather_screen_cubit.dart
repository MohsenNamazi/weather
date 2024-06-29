import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/data/service/geo_locator.dart';

part 'weather_screen_cubit.freezed.dart';
part 'weather_screen_state.dart';

class WeatherScreenCubit extends Cubit<WeatherScreenState> {
  WeatherScreenCubit({
    required OpenWeatherRepo repository,
  })  : _repository = repository,
        super(const WeatherScreenState.initial());

  final OpenWeatherRepo _repository;

  final berlinLocation = UserLocation(lat: 52.5200, lon: 13.4050);

  Future<void> loadWeather({
    UserLocation? userLocation,
    required Units unit,
  }) async {
    try {
      emit(const WeatherScreenState.loading());
      final data = await _repository.getFivedayForecast(
        userLocation: userLocation ?? berlinLocation,
        unit: unit,
      );
      emit(WeatherScreenState.data(data));
    } catch (e, stackTrace) {
      emit(
        WeatherScreenState.error(
          error: e,
          stackTrace: stackTrace,
        ),
      );
      addError(e, stackTrace);
    }
  }
}
