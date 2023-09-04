import 'dart:io';
import 'package:flutter/material.dart';
import 'rotatable_image_widget.dart';
import 'random_words_text.dart';
import 'tima_and_location.dart';

class RandomWordsAndImage extends StatelessWidget {
  final String todo;
  final String location;
  final String? time;
  final String? city;
  final File? image;

  RandomWordsAndImage({required this.todo, required this.location, this.image, this.time,this.city});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        if (time != null && city != null)
        Container(
          width: screenWidth * 0.1,
          child: TimeAndLocationWidget(time: time!, city: city!),
        ),
        SizedBox(width: screenWidth * 0.05),
        Container(
          width: screenWidth * 0.55,
          child: RandomWordsText(todo: todo, location: location),
        ),
        if (image != null)
          Container(
            width: screenWidth * 0.3,
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
