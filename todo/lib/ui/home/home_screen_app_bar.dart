import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/app_bar_widget.dart';
import 'package:todo/ui/widgets/shrink_tap.dart';

import 'avatar/avatar_widget.dart';

class HomeScreenAppBar extends StatefulWidget {
  final VoidCallback onLogout;

  HomeScreenAppBar({required this.onLogout});

  @override
  _HomeScreenAppBarState createState() => _HomeScreenAppBarState();
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      backgroundColor: AppColors.primaryColor,
      circleColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AvatarWiget(),
          SizedBox(height: 10),
          ShrinkTap(
            child: Text(
              "Welcome Susan!",
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () {
              print("ON TAP");
              widget.onLogout();
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
