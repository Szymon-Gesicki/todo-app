import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:todo/controller/keys_controller.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/login/login_screen.dart';
import 'package:todo/ui/started_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    // request to logout user if has expire token
    await Get.find<ProfileRepository>().getProfile();
    final loggedIn = Get.find<ProfileRepository>().isLoggedIn();
    final keysController = Get.find<KeysController>();

    if (keysController.finishedOnboarding) {
      Get.off(() => loggedIn ? HomeScreen() : LoginScreen());
    } else {
      keysController.finishedOnboarding = true;
      Get.off(() => StartedScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
