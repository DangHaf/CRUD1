import 'package:flutter/material.dart';

class Dotted extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  Dotted({
    this.color = Colors.grey,
    this.dashWidth = 5,
    this.dashSpace = 5,
    this.strokeWidth = 2
  });
  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var x = 0.0;
    var y = 0.0; // doc
    final width = size.width;
    final height = size.height;

    // Top
    while (x < width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }

    x = width;
    // Right
    while (y < height) {
      canvas.drawLine(Offset(x, y), Offset(x, y + dashWidth), paint);
      y += dashWidth + dashSpace;
    }

    y = height;
    // Bottom
    while (x > 0) {
      canvas.drawLine(Offset(x, y), Offset(x - dashWidth, y), paint);
      x -= dashWidth + dashSpace;
    }

    x = 0.0;
    // Left
    while (y > 0) {
      canvas.drawLine(Offset(x, y), Offset(x, y - dashWidth), paint);
      y -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}