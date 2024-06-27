abstract class WeatherImageService {
  static String getUrl(String id) =>
      'https://openweathermap.org/img/wn/$id@2x.png';
}
