import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CurvedBG extends StatelessWidget {
  const CurvedBG({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return CustomPaint(
      size: Size(width, 300),
      painter: RPSCustomPainter(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 0, 6, 11)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(Offset(size.width * 0.51, 0),
        Offset(size.width * 1.02, size.height * 0.99), [
      const Color(0xffffc6c6).withOpacity(0.5),
      const Color(0xffffc1c1).withOpacity(0.2)
    ], [
      0.00,
      1.00
    ]);

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width * 1.0190556, size.height * 0.5192000,
        size.width, size.height * 0.6856000);
    path0.cubicTo(
        size.width * 0.8159722,
        size.height * 0.9052000,
        size.width * 0.5764167,
        size.height * 0.9296727,
        size.width * 0.3850556,
        size.height * 0.8788364);
    path0.quadraticBezierTo(size.width * 0.1856944, size.height * 0.8407636, 0,
        size.height * 0.9907636);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
