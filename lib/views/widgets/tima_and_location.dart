import 'package:flutter/material.dart';

class TimeAndLocationWidget extends StatelessWidget {
  final String time; // 時刻（HH:MM形式）
  final String city; // 市

  TimeAndLocationWidget({required this.time, required this.city});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$time',
              style: TextStyle(fontSize: 9),
            ),
            SizedBox(height: 2),
            Text(
              '$city',
              style: TextStyle(fontSize: 9),
            ),
          ],
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,

          child: Container(
            width: 1.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
