import 'package:dio/dio.dart';

class NetworkServiceInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Content-Type': 'application/json',
    });

    super.onRequest(options, handler);
  }
}
