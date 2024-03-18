import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color;

    final Offset center = Offset(size.width / 2, size.height * 0.56);

    canvas.drawCircle(center, size.width * 0.95, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
