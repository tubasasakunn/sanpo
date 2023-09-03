import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/picture.dart';
import '../widgets/rotatable_image_widget.dart';
import '../../services/image_service.dart';
import '../../services/data_service.dart';
import '../widgets/show_picker_options.dart';
import '../widgets/random_words_and_image.dart';
import '../../models/random_words_model.dart';  // ここでRandomWordsModelをインポート

class MultipleImageScreen extends StatefulWidget {
  @override
  _MultipleImageScreenState createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final imageService = ImageService();
  final dataService = DataService();

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
    final newLocation = items.location[Random().nextInt(items.location.length)];
    final newTodo = items.todo[Random().nextInt(items.todo.length)];
    Provider.of<RandomWordsModel>(context, listen: false).addLocation(newLocation);
    Provider.of<RandomWordsModel>(context, listen: false).addTodo(newTodo);
  }

  @override
  void initState() {
    super.initState();
    if (imageService.getSavedImages().isEmpty) {
      _loadAndPickRandomWord();
    }
  }

  @override
  Widget build(BuildContext context) {
  List<Picture> savedImages = imageService.getSavedImages();
  List<String> locations = Provider.of<RandomWordsModel>(context).location;
  List<String> todos = Provider.of<RandomWordsModel>(context).todo;

  return Scaffold(
    body: Stack(
      children: [
        ListView.builder(
          itemCount: max(savedImages.length, locations.length),
          itemBuilder: (context, index) {
            if (index == locations.length - 1) {

          return Container(
            height: MediaQuery.of(context).size.height * 0.3,  // 画面の高さの30%
            color: Colors.grey.withOpacity(0.5),  // 背景色（オプション）
            child: Center(
              child: Text(
                locations[locations.length - 1] + todos[locations.length - 1],
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ),
          );
            }
            
            return RandomWordsAndImage(
              location: locations[index],
              todo: todos[index],
              image: index < savedImages.length ? savedImages[index].image : null,
            );
            
          },
        ),
      ],
    ),
    floatingActionButton: ShowPickerOptions(
      getImageFromCamera: getImageFromCamera,
      getImageFromGallery: getImageFromGallery,
    ),
  );
}

}
