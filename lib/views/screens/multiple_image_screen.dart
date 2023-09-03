import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/picture.dart';
import '../widgets/rotatable_image_widget.dart';
import '../../services/image_service.dart';
import '../../services/data_service.dart';
import '../widgets/show_picker_options.dart';

class MultipleImageScreen extends StatefulWidget {
  @override
  _MultipleImageScreenState createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final imageService = ImageService();
  final dataService = DataService();
  List<String> randomWords = [];

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Picture(_image!));
        _loadAndPickRandomWord();
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Picture(_image!));
        _loadAndPickRandomWord();
      }
    });
  }

  Future<void> _loadAndPickRandomWord() async {
    final items = await dataService.loadData('assets/data.json');
    final newRandomWord = items.location[Random().nextInt(items.todo.length)] + items.todo[Random().nextInt(items.todo.length)];
    setState(() {
      randomWords.add(newRandomWord);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAndPickRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    List<Picture> savedImages = imageService.getSavedImages();
    return Scaffold(
      body: ListView.builder(
        itemCount: max(savedImages.length, randomWords.length),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(randomWords[index]),
            trailing: index < savedImages.length ? RotatableImageWidget(
              imageFile: savedImages[index].image,
              rotation: 0.0,
              scale: 1.0,
            ) : null,
          );
        },
      ),
      floatingActionButton: ShowPickerOptions(
        getImageFromCamera: getImageFromCamera,
        getImageFromGallery: getImageFromGallery,
      ),
    );
  }
}
