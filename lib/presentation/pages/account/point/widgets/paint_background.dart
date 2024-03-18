import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaintBackground extends CustomPainter {
  final Color color;

  PaintBackground({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final Offset center = Offset(size.width / 2, size.height * 0.5);

    canvas.drawOval(
        Rect.fromCenter(
            center: center, width: Get.width * 1.2, height: Get.width * 0.7),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
