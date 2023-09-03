import 'package:flutter/material.dart';
import 'dart:io';

class RotatableImageWidget extends StatelessWidget {
  final File imageFile;
  final double rotation;
  final double scale;

  RotatableImageWidget({
    required this.imageFile,
    this.rotation = 0.0,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Transform.scale(
        scale: scale,
        child: Image.file(imageFile),
      ),
    );
  }
}

