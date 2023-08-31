import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_setup/core/remote/network_service_interceptor.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: 'base_url',
    connectTimeout: const Duration(milliseconds: 1000 * 60),
    sendTimeout: const Duration(milliseconds: 1000 * 60),
    receiveTimeout: const Duration(milliseconds: 1000 * 60),
  );

  final _dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor(),
    ]);

  return _dio;
});
