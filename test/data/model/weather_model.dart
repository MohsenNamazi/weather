import 'package:weather/data/model/weather_model/weather_model.dart';

import 'file_loader.dart';

abstract class WeatherModelFake {
  static Future<WeatherModel> getData() async {
    final testData =
        await FileLoader().loadFile('test/assets/five_days_weather.json');
    return WeatherModel.fromJson(testData);
  }
}
