import 'package:flutter/material.dart';

class PriceRange extends CustomPainter {
  final double low;
  final double high;
  final double priceRightNow;

  PriceRange({super.repaint, required this.low, required this.high, required this.priceRightNow});

  @override
  void paint(Canvas canvas, Size size) {
    print("Drawing");
    
    const double drawLinesHeight = 20;

    final double priceRightNowAsAPercentage = 1 - (high - priceRightNow) / (high - low);

    // Green rect
    Rect rect = const Offset(0, drawLinesHeight) & Size(size.width, 10);
    Paint rectPaint = Paint()
    ..color = Colors.green
    ..strokeWidth = 20;
    
    canvas.drawRect(rect, rectPaint);

    // Red rect
    rect = const Offset(0, drawLinesHeight) & Size(size.width * priceRightNowAsAPercentage, 10);
    rectPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 20;
    canvas.drawRect(rect, rectPaint);

    // Price now
    rect = Offset(size.width * priceRightNowAsAPercentage, drawLinesHeight) & const Size(3, 10);
    rectPaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 20;
    canvas.drawRect(rect, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}