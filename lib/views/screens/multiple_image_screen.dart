import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/picture.dart';
import '../widgets/rotatable_image_widget.dart';
import '../widgets/banner_ad_widget.dart';
import '../../services/image_service.dart';
import '../../services/data_service.dart';
import '../widgets/show_picker_options.dart';
import '../widgets/random_words_and_image.dart';
import '../widgets/random_words_card.dart';
import '../widgets/share_button.dart';
import '../../models/random_words_model.dart';  // ここでRandomWordsModelをインポート
import '../../models/location_time_model.dart';
import 'package:location/location.dart' as loc;  // 位置情報を取得するためのパッケージ
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class MultipleImageScreen extends StatefulWidget {
  @override
  _MultipleImageScreenState createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final imageService = ImageService();
  final dataService = DataService();
  final GlobalKey _globalKey = GlobalKey();

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Picture(_image!));
        _loadAndPickRandomWord();
        _getCurrentLocationAndTime();
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
        _getCurrentLocationAndTime();
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

  Future<void> _getCurrentLocationAndTime() async {
  // 現在地を取得
  loc.Location location = new loc.Location();
  loc.LocationData? locationData;
  try {
    locationData = await location.getLocation();
  } catch (e) {
    print("位置情報の取得に失敗: $e");
  }

  String city = "不明";

  // 位置情報から市名を取得（逆ジオコーディング）
  if (locationData != null) {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);
      Placemark place = placemarks[0];
      city = place.locality ?? "不明";
    } catch (e) {
      print("逆ジオコーディングに失敗: $e");
    }
  }

  // 現時刻を取得
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('HH:mm').format(now);

  // LocationTimeModelに現在地と現時刻を追加
  Provider.of<LocationTimeModel>(context, listen: false).addCity(city);
  Provider.of<LocationTimeModel>(context, listen: false).addTime(formattedTime);
}


@override
void initState() {
  super.initState();
  Future.delayed(Duration.zero, () {
    if (Provider.of<RandomWordsModel>(context, listen: false).location.isEmpty) {
      _loadAndPickRandomWord();
    }
  });
}


  @override
  Widget build(BuildContext context) {
  List<Picture> savedImages = imageService.getSavedImages();
  List<String> locations = Provider.of<RandomWordsModel>(context).location;
  List<String> todos = Provider.of<RandomWordsModel>(context).todo;
  List<String> citys = Provider.of<LocationTimeModel>(context).city;
  List<String> times = Provider.of<LocationTimeModel>(context).time;
  bool isCapturingImage = false;
  void toggleCaptureState() {
    setState(() {
      isCapturingImage = !isCapturingImage;
    });
  }

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.onBackground,
    body: Stack(
      children: [
        RepaintBoundary(
      key: _globalKey,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 200.0,top: 50),
          itemCount: max(savedImages.length, locations.length),
          itemBuilder: (context, index) {
            if (index == locations.length - 1 && !isCapturingImage) {

          return RandomWordsCard(todo: todos[index], location: locations[index]);
            }
            
            return RandomWordsAndImage(
              location: locations[index],
              todo: todos[index],
              image: index < savedImages.length ? savedImages[index].image : null,
              time: index < times.length ? times[index] : null,
              city: index < citys.length ? citys[index] : null,
            );
            
          },
        )),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: BannerAdWidget(),
      ),
      ],
    ),
    
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ShareWidgetButton(globalKey: _globalKey,toggleCaptureState: toggleCaptureState,),
    SizedBox(height: 14),
    ShowPickerOptions(
      getImageFromCamera: getImageFromCamera,
      getImageFromGallery: getImageFromGallery,
    )
    ],) 
  );
}

}
