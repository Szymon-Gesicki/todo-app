import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/login/login_controller.dart';
import 'package:todo/ui/register/register_controller.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/app_bar_widget.dart';
import 'package:todo/ui/widgets/input_widget.dart';
import 'package:todo/ui/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              AppBarWidget(),
              ChangeNotifierProvider<RegisterController>(
                create: (context) => RegisterController(),
                child: Consumer<RegisterController>(
                  builder: (context, controller, child) {
                    return Expanded(child: _body(controller));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(RegisterController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Welcome Onboard!",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20),
          ),
          SizedBox(height: 16),
          Text(
            "We help you meet up you tasks on time.",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputWidget(
                  controller: controller.loginController,
                  type: InputWidgetType.login,
                ),
                SizedBox(height: 32),
                InputWidget(
                  controller: controller.emailController,
                  type: InputWidgetType.email,
                ),
                SizedBox(height: 32),
                InputWidget(
                  controller: controller.passwordController,
                  type: InputWidgetType.password,
                ),
              ],
            ),
          ),
          PrimaryButton(
            text: "Register",
            onPressed: () async {
              if (await controller.register()) Get.off(() => HomeScreen());
            },
            large: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have a account?",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Sing in",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 15, color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
