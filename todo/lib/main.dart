import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/ui/login_screen.dart';
import 'instance_manager.dart';

void main() async {
  await InstanceManager.instance.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
