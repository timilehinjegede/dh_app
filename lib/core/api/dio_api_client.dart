// ignore_for_file: constant_identifier_names
import 'dart:developer';
import 'dart:io';

import 'package:dexter_health/core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHttpApi implements IApiClient {
  final Dio _dio;

  DioHttpApi() : _dio = Dio() {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      contentType: 'application/json',
      validateStatus: _validateStatus,
    );

    // set the options
    _dio.options = baseOptions;

    final presetHeaders = <String, String>{
      Headers.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer KsJ5Ag3',
    };

    _dio.options.headers.addAll(presetHeaders);

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  static String baseUrl = AppConfig.baseUrl;

  @override
  Future<Response> uploadFile(
    String uri, {
    required File file,
  }) async {
    try {
      final formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            file.path,
            filename: 'file',
          ),
        },
      );

      final response = await _dio.post(
        uri,
        data: formData,
      );

      log('response is ${response.data}');
      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  /// validate the status of a request
  bool _validateStatus(int? status) {
    return status! == 200 || status == 201;
  }

  @override
  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response> get(String uri, {Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    throw UnimplementedError();
  }
}

extension ResponseExtension on Response {
  bool get isSuccess {
    final is200 = statusCode == HttpStatus.ok;
    final is201 = statusCode == HttpStatus.created;
    return is200 || is201;
  }
}
