import 'package:get/get.dart';
import 'package:todo/repositories/user/secure_storage.dart';

class UserManager {
  String? _token;

  UserManager() {
    init();
  }

  Future<void> init() async {
    _token = await Get.find<SecureStorage>().getAuthToken();
  }

  bool isLoggedIn() {
    return _token != null;
  }

  String? getAuthToken() {
    return _token;
  }

  void saveAuthToken(String? token) async {
    await Get.find<SecureStorage>().saveAuthToken(token);
    _token = await Get.find<SecureStorage>().getAuthToken();
  }
}
