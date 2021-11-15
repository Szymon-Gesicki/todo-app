import 'package:get/instance_manager.dart';
import 'package:todo/controller/keys_controller.dart';
import 'package:todo/controller/storage_service.dart';
import 'package:todo/network/todo_client.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/repositories/user/secure_storage.dart';
import 'package:todo/repositories/user/user_manager.dart';

class DependencyManager {
  static final instance = DependencyManager();

  Future init() async {
    Get.put(StorageService());
    await Get.find<StorageService>().init();
    Get.put(KeysController());

    Get.put(SecureStorage());
    Get.put(UserManager());

    Get.put(TodoClient());

    Get.put(ProfileRepository());
  }
}
