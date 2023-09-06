import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';

class RotatableImageWidget extends StatelessWidget {
  final File imageFile;
  final double rotation;
  final double scale;

  RotatableImageWidget({
    required this.imageFile,
    this.rotation = 0.0,
    this.scale = 1.0,
  });

  Color getRandomColor(String seed) {
    // ファイルパスからハッシュコードを生成して、それをシード値とする
    final int seedValue = seed.hashCode;
    Random random = Random(seedValue);

    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    double diameter = MediaQuery.of(context).size.width / 8; // 8はマジックナンバー

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.file(imageFile),
              ),
            );
          },
        );
      },
      child: Stack(
      alignment: Alignment.center,
      children: [
        // 縦線
                Positioned(
          top: 0,
          bottom: 0,

          child: Container(
            width: 1.0,
            color: Colors.black,
          ),
        ),
        Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), // 上下に20.0の余白を追加
      child: Transform.scale(
          scale: 1,
        child: Transform.rotate(
        angle: rotation,
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).colorScheme.background, // ランダムな色
                  width: 2, // 枠線の幅
                ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(imageFile),
              ),
            ),
          ),
        ),
      ),
      )
      ])
    );
  }
}
