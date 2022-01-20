import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:todo/models/user.dart';
import 'package:todo/network/models/login_request.dart';
import 'package:todo/network/models/register_request.dart';
import 'package:todo/network/todo_api/todo_api.dart';
import 'package:todo/network/todo_client.dart';
import 'package:todo/repositories/user/user_manager.dart';
import 'package:todo/ui/login/login_screen.dart';

class SimpleResult<T> {
  final bool success;
  final T? result;
  final String? error;

  SimpleResult._inner(this.success, this.result, this.error);

  factory SimpleResult.createEmptySuccess() =>
      SimpleResult._inner(true, null, null);

  factory SimpleResult.createSuccess(T? result) =>
      SimpleResult._inner(true, result, null);

  factory SimpleResult.createFailed(String? error) =>
      SimpleResult._inner(false, null, error);
}

class ProfileRepository {
  final UserManager _userManager = Get.find();

  final _logOutBroadcast = StreamController<void>.broadcast();
  Stream<void> get logOutBroadcast => _logOutBroadcast.stream;

  TodoApi _todoApi = Get.find<TodoClient>().todoApi;

  ProfileRepository();

  bool isLoggedIn() {
    final token = Get.find<UserManager>().getAuthToken();
    return (token != null);
  }

  Future<SimpleResult<void>> login(String username, String password) async {
    try {
      final response = await _todoApi.login(LoginRequest(username, password));
      _userManager.saveAuthToken(response.key);
      return SimpleResult.createEmptySuccess();
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return SimpleResult.createFailed("failure_on_login");
      }
      if (e.error is SocketException) {
        return SimpleResult.createFailed("error_check_internet");
      }
      return SimpleResult.createFailed("Unknown error");
    } on Exception catch (e) {
      return SimpleResult.createFailed("Unknown error");
    }
  }

  Future<SimpleResult<void>> register(
      String username, String password, String email) async {
    try {
      final response = await _todoApi
          .register(RegisterRequest(username, email, password, password));
      _userManager.saveAuthToken(response.key);
      return SimpleResult.createEmptySuccess();
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return SimpleResult.createFailed("Incorrect credentials");
      }

      if (e.error is SocketException) {
        return SimpleResult.createFailed("Check internet");
      }

      if (e.response != null) {
        print("result");

        Map<String, dynamic> result = jsonDecode(e.response.toString());

        final email = result["email"];
        final password = result["password1"];
        final username = result["username"];

        if (username != null) {
          return SimpleResult.createFailed(username[0] as String);
        }
        if (email != null) {
          return SimpleResult.createFailed(email[0] as String);
        }

        if (password != null) {
          return SimpleResult.createFailed(password[0] as String);
        }

        return SimpleResult.createFailed("Unknown error");
      } else {
        return SimpleResult.createFailed("Unknown error");
      }
    }
  }

  Future<SimpleResult<User>> getProfile() async {
    try {
      final response = await _todoApi.getProfile();
      return SimpleResult.createSuccess(UserMapper.fromNetwork(response));
    } on DioError catch (e) {
      return SimpleResult.createFailed("Unknown error");
    }
  }

  void logout() {
    _logOutBroadcast.add(null);
    _userManager.saveAuthToken(null);
    Get.off(() => LoginScreen());
  }
}
