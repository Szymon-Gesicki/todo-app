import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AvatarWigetController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    // TODO IMAGE
    Future.delayed(Duration(milliseconds: 1000), () {
      isLoading.value = false;
    });
  }
}
