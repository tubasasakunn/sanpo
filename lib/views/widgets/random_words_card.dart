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
            painter: RightTrianglePainter(triangleSize,Theme.of(context).colorScheme.background),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '$location ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        SizedBox(height: 14),
Align(
  alignment: Alignment.centerRight,
          child: CustomPaint(
            painter: LeftTrianglePainter(triangleSize,Theme.of(context).colorScheme.background),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                ' $todo',
                style: Theme.of(context).textTheme.bodyLarge,
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
  final Color paintColor;
  

  RightTrianglePainter(this.triangleSize,this.paintColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = paintColor
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
  final Color paintColor;

  LeftTrianglePainter(this.triangleSize,this.paintColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = paintColor
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
