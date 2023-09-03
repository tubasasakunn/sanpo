import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // 追加
import '../../models/picture.dart';
import '../widgets/rotatable_image_widget.dart';
import '../../services/image_service.dart';  // 名前を変更
import '../widgets/show_picker_options.dart';

class MultipleImageScreen extends StatefulWidget {  // StatefulWidgetに変更
  @override
  _MultipleImageScreenState createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final imageService = ImageService();  // シングルトンインスタンスを取得

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Picture(_image!));  // 既存のシングルトンインスタンスを使用
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Picture(_image!));  // 既存のシングルトンインスタンスを使用
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Picture> savedImages = imageService.getSavedImages();
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Image Screen'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: savedImages.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 300,  // 高さを指定
              child: RotatableImageWidget(
                imageFile: savedImages[index].image,
                rotation: 0.0,
                scale: 1.0,
              ),
            );
          },
        ),
      ),
      floatingActionButton: ShowPickerOptions(
        getImageFromCamera: getImageFromCamera,
        getImageFromGallery: getImageFromGallery,
      ),
    );
  }
}
