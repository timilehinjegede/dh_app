import 'dart:io';

import 'package:dio/dio.dart';

abstract class IApiClient {
  /// get
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  });

  /// post
  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  /// put
  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  /// delete
  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  /// upload file
  Future<Response> uploadFile(
    String uri, {
    required File file,
  });
}
