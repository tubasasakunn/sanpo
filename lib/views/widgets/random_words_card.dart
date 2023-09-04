import 'package:flutter/material.dart';

class RandomWordsCard extends StatelessWidget {
  final String todo;
  final String location;

  RandomWordsCard({required this.todo, required this.location});

  @override
  Widget build(BuildContext context) {
    final double triangleSize = 20.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
  alignment: Alignment.centerLeft,
          child: CustomPaint(
            painter: RightTrianglePainter(triangleSize),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '$location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
Align(
  alignment: Alignment.centerRight,
          child: CustomPaint(
            painter: LeftTrianglePainter(triangleSize),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '$todo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RightTrianglePainter extends CustomPainter {
  final double triangleSize;

  RightTrianglePainter(this.triangleSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - triangleSize, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - triangleSize, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LeftTrianglePainter extends CustomPainter {
  final double triangleSize;

  LeftTrianglePainter(this.triangleSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(triangleSize, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(triangleSize, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
