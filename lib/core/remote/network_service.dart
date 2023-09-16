import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_setup/core/env/env_reader.dart';
import 'package:flutter_setup/core/remote/network_service_interceptor.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final envReader = ref.watch(envReaderProvider);

  final options = BaseOptions(
    baseUrl: envReader.getBaseUrl(),
    connectTimeout: const Duration(milliseconds: 1000 * 60),
    sendTimeout: const Duration(milliseconds: 1000 * 60),
    receiveTimeout: const Duration(milliseconds: 1000 * 60),
  );

  final _dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor(),
    ]);

  // _dio.httpClientAdapter = IOHttpClientAdapter(
  //   createHttpClient: () {
  //     final securityContext = SecurityContext.defaultContext;
  //     final client = HttpClient();
  //     securityContext.setTrustedCertificatesBytes(envReader.getCertificate());
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) {
  //       return false;
  //     };
  //     return client;
  //   },
  // );

  return _dio;
});
