import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/data/network/dio/dio_request.dart';

typedef RequestMockData = ({
  String path,
  RequestMethod method,
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic> response,
});

class DioMock extends Mock implements Dio {
  Dio mockData(
    String path,
    Map<String, dynamic> response, {
    Map<String, dynamic>? queryParameters,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.openweathermap.org',
        queryParameters: queryParameters,
      ),
    );
    final adapter = DioAdapter(
      dio: dio,
      matcher: const UrlRequestMatcher(),
    )..onGet(path, (server) {
        server.reply(200, response);
      });
    dio.httpClientAdapter = adapter;

    return dio;
  }

  Dio mockError(String path, DioException exception) {
    final dio = Dio(
      BaseOptions(baseUrl: 'https://api.openweathermap.org'),
    );
    final adapter = DioAdapter(
      dio: dio,
      matcher: const UrlRequestMatcher(),
    )..onGet(path, (server) {
        server.reply(400, exception);
      });
    dio.httpClientAdapter = adapter;

    return dio;
  }
}
