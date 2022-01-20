import 'package:get/get.dart';
import 'package:todo/controller/storage_service.dart';

enum Keys {
  finishedOnboarding,
}

class KeysController {
  StorageService service = Get.find<StorageService>();

  bool get finishedOnboarding {
    return service.getBool(Keys.finishedOnboarding.toString(), false);
  }

  set finishedOnboarding(bool value) {
    service.put(Keys.finishedOnboarding.toString(), value);
  }
}
