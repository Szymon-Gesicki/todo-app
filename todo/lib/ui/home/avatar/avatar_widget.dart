import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo/ui/home/avatar/avatar_widget_controller.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/shrink_tap.dart';
import 'avatar_widget_controller.dart';

class AvatarWiget extends StatelessWidget {
  final AvatarWigetController _controller = Get.put(AvatarWigetController());
  final _size = 70.0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_controller.isLoading.value) {
          return Container(
            height: _size,
            width: _size,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
          );
        } else {
          return ShrinkTap(child: _iconAvatar(), onTap: () {});
        }
      },
    );
  }

  Widget _iconAvatar() {
    return FaDuotoneIcon(
      FontAwesomeIcons.duotoneUserCircle as IconDataDuotone,
      primaryColor: AppColors.primaryColor,
      secondaryColor: Colors.white,
      size: 70,
    );
  }
}
