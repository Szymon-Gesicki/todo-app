import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo/dependency_manager.dart';
import 'package:todo/ui/splash/splash_screen.dart';
import 'package:todo/ui/style/app_theme.dart';

void main() async {
  await DependencyManager.instance.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo app',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SplashScreen(),
    );
  }
}
