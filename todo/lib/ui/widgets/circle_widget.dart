import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleWidget extends StatelessWidget {
  final double size;
  final double percent;
  final Color color;

  const CircleWidget({
    this.size = 50,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    MyPainter painter = MyPainter();
    painter.percent = percent;
    painter.color = color;
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        painter: painter,
        size: Size(size, size),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double percent = 100;
  Color color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(0, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      3 / 2 * math.pi, // zero point
      2 * math.pi * percent / 100, // size
      true, // start in center
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
