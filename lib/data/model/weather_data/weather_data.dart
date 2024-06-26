import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/clouds/clouds.dart';
import 'package:weather/data/model/main/main.dart';
import 'package:weather/data/model/rain/rain.dart';
import 'package:weather/data/model/sys/sys.dart';
import 'package:weather/data/model/weather/weather.dart';
import 'package:weather/data/model/wind/wind.dart';

part 'weather_data.freezed.dart';
part 'weather_data.g.dart';

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    required int dt,
    required Main main,
    required List<Weather> weather,
    required Clouds clouds,
    required Wind wind,
    required int visibility,
    required double pop,
    required Rain? rain,
    required Sys sys,
    @JsonKey(name: 'dt_txt') required String dtTxt,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}
