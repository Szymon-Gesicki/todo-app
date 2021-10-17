import 'package:flutter/material.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/circle_widget.dart';

class AppBarWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color circleColor;
  final _circleSize = 220.0;
  final Widget? body;

  const AppBarWidget({
    this.backgroundColor = AppColors.background,
    this.circleColor = AppColors.primaryColor,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          color: backgroundColor,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: body,
          ),
        ),
        CircleWidget(
            size: _circleSize,
            percent: 50,
            color: circleColor.withOpacity(0.5)),
        RotatedBox(
          quarterTurns: 1,
          child: CircleWidget(
              size: _circleSize,
              percent: 50,
              color: circleColor.withOpacity(0.5)),
        ),
      ],
    );
  }
}
