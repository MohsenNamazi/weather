part of 'weather_screen_cubit.dart';

@freezed
class WeatherScreenState with _$WeatherScreenState {
  const factory WeatherScreenState.initial() = _Initial;
  const factory WeatherScreenState.loading() = _Loading;
  const factory WeatherScreenState.data(WeatherModel language) = _Data;
  const factory WeatherScreenState.error({
    Object? error,
    StackTrace? stackTrace,
  }) = _Error;
}
