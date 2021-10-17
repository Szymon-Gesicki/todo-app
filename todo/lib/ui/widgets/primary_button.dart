import 'package:flutter/material.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/baseline_text.dart';
import 'package:todo/ui/widgets/shrink_tap.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool large;

  PrimaryButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShrinkTap(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: large
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: backgroundColor,
        ),
        child: BaselineText(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
