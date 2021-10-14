import 'package:todo/repositories/user/secure_storage.dart';

class UserManager {
  static final UserManager instance = UserManager._inner();

  String? _token;

  UserManager._inner();

  Future<void> init() async {
    _token = await SecureStorage.instance.getAuthToken();
  }

  bool isLoggedIn() {
    return _token != null;
  }

  String? getAuthToken() {
    return _token;
  }

  void saveAuthToken(String? token) async {
    this._token = token;
    await SecureStorage.instance.saveAuthToken(token);
  }
}
