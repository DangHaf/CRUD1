import 'package:flutter/material.dart';
class CirclePainterTop extends CustomPainter {
  final Color color;

  CirclePainterTop({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color;

    final Offset center = Offset(size.width / 2, size.height * 0.35);

    canvas.drawCircle(center, size.width * 0.7, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
