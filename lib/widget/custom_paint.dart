import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.blackLightColor // Color of the dotted line
      ..strokeWidth = 2.0 // Adjust the thickness of the line
      ..strokeCap = StrokeCap.round; // Round cap for a smoother appearance

    double dashWidth = 5.0; // Width of each dash in the dotted line
    double dashSpace = 5.0; // Space between each dash

    double startX = 0.0;
    double endX = size.width; // Change to size.width for a horizontal line

    for (double i = startX; i < endX; i += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(i, 0.0),
        Offset(i + dashWidth, 0.0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}