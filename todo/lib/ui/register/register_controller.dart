import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/managers/toast_notification.dart';
import 'package:todo/repositories/user/profile_repository.dart';

class RegisterController extends ChangeNotifier {
  bool _loading = false;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get loginController => _loginController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  bool get isLoading => _loading;

  Future<bool> register() async {
    if (isLoading) return false;

    _loading = true;
    notifyListeners();

    if (!_validateInput()) {
      _loading = false;
      notifyListeners();
      return false;
    }
    final result = await Get.find<ProfileRepository>().register(
        _loginController.text, _passwordController.text, _emailController.text);

    _loading = false;

    if (!result.success) {
      ToastNotification.fire(result.error!);
    }

    notifyListeners();

    return result.success;
  }

  bool _validateInput() {
    if (_loginController.text.isEmpty) {
      ToastNotification.fire("Please enter login");
      return false;
    }

    if (_passwordController.text.isEmpty) {
      ToastNotification.fire("Please enter password");
      return false;
    }

    if (_emailController.text.isEmpty) {
      ToastNotification.fire("Please enter email");
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _loginController.dispose();
    super.dispose();
  }
}
