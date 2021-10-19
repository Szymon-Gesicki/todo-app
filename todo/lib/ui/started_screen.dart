import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/ui/login_screen.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/app_bar_widget.dart';
import 'package:todo/ui/widgets/primary_button.dart';

class StartedScreen extends StatefulWidget {
  @override
  _StartedScreenState createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppBarWidget(),
          Expanded(
            child: _body(),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: SvgPicture.asset(
              "assets/images/get_started.svg",
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Let's get thinkgs done on time",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20),
          ),
          SizedBox(height: 16),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tellus praesent purus tincidunt ut cursus vitae. Nisl, vitae nulla lectus tortor, est a aliquam. Pretium netus ",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline3!.copyWith(fontSize: 20),
          ),
          Spacer(flex: 1),
          PrimaryButton(
            text: "Get Started",
            onPressed: () {
              onFinished();
            },
            large: true,
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  void onFinished() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
