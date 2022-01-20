import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/style/colors.dart';

class DialogButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isEnable;

  DialogButton({
    this.isEnable = true,
    required this.text,
    required this.textColor,
    required this.onPressed,
  });

  @override
  _DialogButtonState createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
  static final PressedColor = AppColors.lightBlue;
  static final ReleasedColor = Colors.transparent;

  Color _backgroundColor = ReleasedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.isEnable) widget.onPressed();
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _backgroundColor = ReleasedColor;
        });
      },
      onTapCancel: () {
        setState(() {
          _backgroundColor = ReleasedColor;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _backgroundColor = PressedColor;
        });
      },
      child: ColoredBox(
        color: widget.isEnable ? _backgroundColor : PressedColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 50),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
