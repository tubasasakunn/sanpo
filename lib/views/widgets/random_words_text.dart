import 'package:flutter/material.dart';

class RandomWordsText extends StatelessWidget {
  final String todo;
  final String location;

  RandomWordsText({required this.todo, required this.location});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
      '$location\n$todo',
      style: Theme.of(context).textTheme.bodyMedium,
      softWrap: true,
    ),
    Positioned(
          left: 0,
          bottom: 0,
          right: 0,

          child: Container(
            height: 1.0,
            color: Theme.of(context).colorScheme.background,
          ),
        )]
        );
  }
}
