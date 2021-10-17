import 'package:flutter/material.dart';

/// Centers text vertically, removes bottom padding reserved for e.g. y
/// Great for texts on caps: EXAMPLE TEXT
class BaselineText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? textScaleFactor;
  final TextAlign? textAlign;

  /// Chosen experimentally, adjusted for used font
  final double lineHeight;

  BaselineText(
    this.text, {
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textScaleFactor,
    this.lineHeight = 1.4,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? DefaultTextStyle.of(context).style;

    return Container(
      child: Text(
        text,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
        textScaleFactor: textScaleFactor,
        style: textStyle.copyWith(height: lineHeight),
      ),
    );
  }
}
