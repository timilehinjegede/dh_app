// ignore_for_file: constant_identifier_names
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
    };

    _dio.options.headers.addAll(presetHeaders);

    if (kDebugMode) {
      _dio.interceptors.addAll(
        [
          LogInterceptor(
            requestHeader: false,
            requestBody: true,
            responseBody: true,
            error: true,
          ),
        ],
      );
    }
  }

  static String baseUrl = AppConfig.baseUrl;

  @override
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      if (extraHeaders != null) {
        _dio.options.headers.addAll(extraHeaders);
      }
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  @override
  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  @override
  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }

  @override
  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
      );

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
  Future<Response> uploadFiles(
    String uri, {
    required List<File> files,
  }) async {
    try {
      final formData = FormData.fromMap(
        {
          'files': [
            for (final file in files)
              await MultipartFile.fromFile(
                file.path,
              ),
          ],
        },
      );

      final response = await _dio.post(
        uri,
        data: formData,
      );

      return response;
    } catch (e) {
      throw ApiException.getException(e);
    }
  }
}

extension ResponseExtension on Response {
  bool get isSuccess {
    final is200 = statusCode == HttpStatus.ok;
    final is201 = statusCode == HttpStatus.created;
    return is200 || is201;
  }
}
