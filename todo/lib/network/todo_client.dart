import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/network/http_response.dart';
import 'package:todo/network/todo_api/todo_api.dart';

import 'network_urls.dart';

class TodoClient {
  static final instance = TodoClient._inner();

  final Dio dio = Dio(BaseOptions(baseUrl: NetworkUrls.SERVER_API));
  late TodoApi todoApi;

  TodoClient._inner() {
    todoApi = TodoApi(dio);

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // final token = await UserManager.instance.getAuthToken();
      // if (!options.path.contains('oauth') && token != null) {
      //   options.headers['Authorization'] = token;
      // }
    }, onResponse: (response, handler) {
      handler.next(response);
    }, onError: (error, handler) {
      HTTPResponse httpResponse =
          HTTPResponseExtension.from(error.response?.statusCode);

      switch (httpResponse) {
        case HTTPResponse.unauthorized:
          // ProfileRepository.instance.logout();
          break;
        default:
          break;
      }

      handler.next(error);
    }));

    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: false));
    }
  }
}
