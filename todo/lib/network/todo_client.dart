import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo/network/http_response.dart';
import 'package:todo/network/todo_api/todo_api.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/repositories/user/user_manager.dart';

import 'network_urls.dart';

class TodoClient {
  final UserManager _userManager = Get.find();

  final Dio dio = Dio(BaseOptions(baseUrl: NetworkUrls.SERVER_API));
  late TodoApi todoApi;

  TodoClient() {
    todoApi = TodoApi(dio);

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          HTTPResponse httpResponse =
              HTTPResponseExtension.from(e.response?.statusCode);

          switch (httpResponse) {
            case HTTPResponse.unauthorized:
              Get.find<ProfileRepository>().logout();
              break;
            default:
              break;
          }

          handler.next(e);
        },
        onRequest: (r, handler) {
          print("ADD TOKEN");
          final token = _userManager.getAuthToken();
          print("TOKEN ${token}");
          if (token != null) r.headers['Authorization'] = token;
          handler.next(r);
        },
        onResponse: (r, handler) {
          handler.next(r);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: false));
    }
  }
}
