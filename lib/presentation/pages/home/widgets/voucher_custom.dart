import 'package:flutter/material.dart';

class VoucherCustom extends CustomPainter {
  final Color? color;

  VoucherCustom({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path0 = Path();
    path0.moveTo(0, size.height * 0.1250000);
    path0.cubicTo(0, size.height * 0.05596437, size.width * 0.01658206, 0,
        size.width * 0.03703704, 0);
    path0.lineTo(size.width * 0.9629630, 0);
    path0.cubicTo(size.width * 0.9834185, 0, size.width,
        size.height * 0.05596444, size.width, size.height * 0.1250000);
    path0.lineTo(size.width, size.height * 0.3501431);
    path0.cubicTo(
        size.width,
        size.height * 0.3855438,
        size.width * 0.9951574,
        size.height * 0.4189625,
        size.width * 0.9868778,
        size.height * 0.4406963);
    path0.cubicTo(
        size.width * 0.9693815,
        size.height * 0.4866250,
        size.width * 0.9693815,
        size.height * 0.5758750,
        size.width * 0.9868778,
        size.height * 0.6218037);
    path0.cubicTo(size.width * 0.9951574, size.height * 0.6435375, size.width,
        size.height * 0.6769563, size.width, size.height * 0.7123563);
    path0.lineTo(size.width, size.height * 0.8750000);
    path0.cubicTo(size.width, size.height * 0.9440375, size.width * 0.9834185,
        size.height, size.width * 0.9629630, size.height);
    path0.lineTo(size.width * 0.03703704, size.height);
    path0.cubicTo(size.width * 0.01658202, size.height, 0,
        size.height * 0.9440375, 0, size.height * 0.8750000);
    path0.lineTo(0, size.height * 0.7090625);
    path0.cubicTo(
        0,
        size.height * 0.6753000,
        size.width * 0.004046704,
        size.height * 0.6429687,
        size.width * 0.01121931,
        size.height * 0.6194369);
    path0.lineTo(size.width * 0.02010019, size.height * 0.5902962);
    path0.cubicTo(
        size.width * 0.03393019,
        size.height * 0.5449162,
        size.width * 0.03112778,
        size.height * 0.4675331,
        size.width * 0.01446650,
        size.height * 0.4347313);
    path0.cubicTo(size.width * 0.005508426, size.height * 0.4170950, 0,
        size.height * 0.3847275, 0, size.height * 0.3497256);
    path0.lineTo(0, size.height * 0.1250000);
    path0.close();

    final Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = color ?? const Color(0xffDC4C64).withOpacity(1.0);
    canvas.drawPath(path0, paint0fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}