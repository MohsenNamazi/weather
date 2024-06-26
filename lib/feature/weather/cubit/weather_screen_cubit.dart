import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/repository/open_weather_repo.dart';

part 'weather_screen_cubit.freezed.dart';
part 'weather_screen_state.dart';

class WeatherScreenCubit extends Cubit<WeatherScreenState> {
  WeatherScreenCubit({
    required OpenWeatherRepo repository,
  })  : _repository = repository,
        super(const WeatherScreenState.initial());

  final OpenWeatherRepo _repository;

  Future<void> getCurrentLanguage() async {
    try {
      final data = await _repository.get5dayForecast(
        latitude: '24',
        longitude: '28',
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
