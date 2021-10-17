import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const KEY_AUTH_TOKEN = "KEY_AUTH_TOKEN";
  static SecureStorage instance = SecureStorage();
  FlutterSecureStorage _secureStorage = new FlutterSecureStorage();
  String? _cachedToken;

  Future<String?> getAuthToken() async {
    if (_cachedToken != null) return _cachedToken;

    try {
      _cachedToken = await _secureStorage.read(key: KEY_AUTH_TOKEN);
    } catch (e) {
      await deleteAll();
    }
    return _cachedToken;
  }

  Future deleteAll() async {
    try {
      // https://github.com/mogol/flutter_secure_storage/issues/43
      await _secureStorage.deleteAll();
    } catch (e) {}
  }

  Future<void> saveAuthToken(String? token) async {
    _cachedToken = token != null ? "Token $token" : null;
    await _secureStorage.write(key: KEY_AUTH_TOKEN, value: _cachedToken);
  }
}
