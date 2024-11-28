import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final List<double> dataPoints;

  LineChartPainter({required this.dataPoints});

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    
    final shadowPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);

    
    final path = Path();
    final shadowPath = Path();
    double spacing = size.width / (dataPoints.length - 1);

    
    double maxDataPoint = dataPoints.reduce((a, b) => a > b ? a : b);
    double minDataPoint = dataPoints.reduce((a, b) => a < b ? a : b);

    
    double verticalScale = maxDataPoint == minDataPoint
        ? 1.0
        : size.height / (maxDataPoint - minDataPoint);

    
    double margin = 10.0;

    
    for (int i = 0; i < dataPoints.length; i++) {
      double x = spacing * i;
      double y = size.height - (dataPoints[i] - minDataPoint) * verticalScale - margin;

      
      if (i == 0) {
        path.moveTo(x, y);
        shadowPath.moveTo(x, y);
      } else {
        
        double prevX = spacing * (i - 1);
        double prevY = size.height - (dataPoints[i - 1] - minDataPoint) * verticalScale - margin;

        double midX = (prevX + x) / 2;
        path.quadraticBezierTo(midX, prevY, x, y);
        shadowPath.quadraticBezierTo(midX, prevY, x, y);
      }

      
      canvas.drawCircle(Offset(x, y), 4.0, pointPaint);
    }

    
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
