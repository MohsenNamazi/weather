import 'package:dio/dio.dart';

enum RequestMethod {
  get('GET'),
  put('PUT'),
  delete('DELETE'),
  post('POST');

  const RequestMethod(this.name);
  final String name;
}

abstract class DioRequest {
  DioRequest(this._dio, this.baseUrl);
  final Dio _dio;
  String? baseUrl;

  Future<Response<Map<String, dynamic>>> setDioRequest({
    required String url,
    required RequestMethod method,
    dynamic data,
    String? contentType,
    Map<String, dynamic>? queryParameters,
  }) async {
    final origin = baseUrl ?? _dio.options.baseUrl;
    final options = Options(
      method: method.name,
      contentType: contentType,
    )
        .compose(
          _dio.options,
          url,
          data: data,
          queryParameters: queryParameters,
        )
        .copyWith(baseUrl: origin);
    return _dio.fetch<Map<String, dynamic>>(options);
  }
}
