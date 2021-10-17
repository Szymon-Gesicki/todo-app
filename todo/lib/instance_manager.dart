import 'package:get/instance_manager.dart';
import 'package:todo/network/todo_client.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/repositories/user/secure_storage.dart';
import 'package:todo/repositories/user/user_manager.dart';

class InstanceManager {
  static final instance = InstanceManager();

  Future init() async {
    Get.put(SecureStorage());
    Get.put(UserManager());

    Get.put(TodoClient());

    Get.put(ProfileRepository());
  }
}
