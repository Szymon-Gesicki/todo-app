import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/locale_keys.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/login/login_controller.dart';
import 'package:todo/ui/register/register_screen.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/app_bar_widget.dart';
import 'package:todo/ui/widgets/input_widget.dart';
import 'package:todo/ui/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
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
              ChangeNotifierProvider<LoginController>(
                create: (context) => LoginController(),
                child: Consumer<LoginController>(
                  builder: (context, controller, child) {
                    return Expanded(child: _body(controller, context));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(LoginController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            LocaleKeys.welcomeBack,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20),
          ),
          SizedBox(height: 32),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: SvgPicture.asset(
              "assets/images/login.svg",
            ),
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
                  controller: controller.passwordController,
                  type: InputWidgetType.password,
                ),
              ],
            ),
          ),
          PrimaryButton(
            text: LocaleKeys.singIn,
            onPressed: () async {
              if (await controller.login()) Get.off(() => HomeScreen());
            },
            large: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.dontHaveAccount,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => RegisterScreen());
                },
                child: Text(
                  LocaleKeys.signUp,
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
