import 'dart:io';
import 'package:flutter/material.dart';
import 'rotatable_image_widget.dart';
import 'random_words_text.dart';

class RandomWordsAndImage extends StatelessWidget {
  final String todo;
  final String location;
  final File? image;

  RandomWordsAndImage({required this.todo, required this.location, this.image});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: screenWidth * 0.6,
          child: RandomWordsText(todo: todo, location: location),
        ),
        if (image != null)
          Container(
            width: screenWidth * 0.4,
            child: RotatableImageWidget(
              imageFile: image!,
              rotation: 0.0,
              scale: 1.0,
            ),
          ),
      ],
    );
  }
}
