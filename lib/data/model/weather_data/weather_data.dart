import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/data/model/clouds/clouds.dart';
import 'package:weather/data/model/main/main.dart';
import 'package:weather/data/model/rain/rain.dart';
import 'package:weather/data/model/sys/sys.dart';
import 'package:weather/data/model/weather/weather.dart';
import 'package:weather/data/model/wind/wind.dart';
import 'package:weather/feature/common/extentions/build_context.dart';

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

extension WeatherDataConverter on WeatherData {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(dt * 1000);

  String dayName(BuildContext context) {
    final l10n = context.l10n;
    switch (dateTime.weekday) {
      case DateTime.monday:
        return l10n.monday;
      case DateTime.tuesday:
        return l10n.tuesday;
      case DateTime.wednesday:
        return l10n.wednesday;
      case DateTime.thursday:
        return l10n.thursday;
      case DateTime.friday:
        return l10n.friday;
      case DateTime.saturday:
        return l10n.saturday;
      case DateTime.sunday:
        return l10n.sunday;
      default:
        return '';
    }
  }

  String dayShortName(BuildContext context) {
    final l10n = context.l10n;
    switch (dateTime.weekday) {
      case DateTime.monday:
        return l10n.mondayShort;
      case DateTime.tuesday:
        return l10n.tuesdayShort;
      case DateTime.wednesday:
        return l10n.wednesdayShort;
      case DateTime.thursday:
        return l10n.thursdayShort;
      case DateTime.friday:
        return l10n.fridayShort;
      case DateTime.saturday:
        return l10n.saturdayShort;
      case DateTime.sunday:
        return l10n.sundayShort;
      default:
        return '';
    }
  }
}
