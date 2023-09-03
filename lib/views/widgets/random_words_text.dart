import 'package:flutter/material.dart';

class RandomWordsText extends StatelessWidget {
  final String todo;
  final String location;

  RandomWordsText({required this.todo, required this.location});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$location\n$todo',
      softWrap: true,
    );
  }
}
