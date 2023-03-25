

import 'package:flutter/material.dart';

class ForHeadlineDesign extends CustomPainter {
  BuildContext context;
  ForHeadlineDesign({
    required this.context,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Theme.of(context).colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    Path path = Path();
    path.moveTo(
      0,
      size.height / 3,
    );
    path.conicTo(size.width / 2, 0, size.width, size.height / 2, 1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
