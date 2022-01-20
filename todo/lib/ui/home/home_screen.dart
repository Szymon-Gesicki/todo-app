import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/ui/home/task_list.dart';
import 'package:todo/ui/style/colors.dart';
import 'home_screen_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeScreenAppBar(
                onLogout: () {
                  print("LOGOUT");
                  Get.find<ProfileRepository>().logout();
                },
              ),
              Expanded(child: _body(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tasks List",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(height: 10),
          TasksList(),
        ],
      ),
    );
  }
}
