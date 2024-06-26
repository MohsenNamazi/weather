import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/city/city.dart';
import 'package:weather/data/model/weather_data/weather_data.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required String cod,
    required int message,
    required int cnt,
    required List<WeatherData> list,
    required City city,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
