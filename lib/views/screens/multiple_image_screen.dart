import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/picture.dart';
import '../widgets/rotatable_image_widget.dart';
import '../widgets/banner_ad_widget.dart';
import 'package:sanpo/models/data.dart';
import '../../services/image_service.dart';
import '../../services/data_service.dart';
import '../widgets/show_picker_options.dart';
import '../widgets/random_words_and_image.dart';
import '../widgets/random_words_card.dart';
import '../widgets/share_button.dart';
import '../../models/random_words_model.dart';  // ここでRandomWordsModelをインポート
import '../../models/location_time_model.dart';
import '../../models/app_state.dart';
import 'package:location/location.dart' as loc;  // 位置情報を取得するためのパッケージ
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import '../widgets/interstitial_ad_manager.dart';

class MultipleImageScreen extends StatefulWidget {
  @override
  _MultipleImageScreenState createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final imageService = ImageService();
  final GlobalKey _globalKey = GlobalKey();
  final InterstitialAdManager interstitialAdManager = InterstitialAdManager();

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Provider.of<AppStateModel>(context, listen: false).label,Picture(_image!));
        _loadAndPickRandomWord();
        _getCurrentLocationAndTime();
        interstitialAdManager.showInterstitialAd();
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(Provider.of<AppStateModel>(context, listen: false).label,Picture(_image!));
        _loadAndPickRandomWord();
        _getCurrentLocationAndTime();
        interstitialAdManager.showInterstitialAd();
      }
    });
  }

  Future<void> _loadAndPickRandomWord() async {

    final Tuple2<String, String> item = await Provider.of<DataService>(context, listen: false).loadRandomData(context);
    final newLocation = item.item1;
    final newTodo = item.item2;
    

    Provider.of<RandomWordsModel>(context, listen: false).addLocation(Provider.of<AppStateModel>(context, listen: false).label,newLocation);
    Provider.of<RandomWordsModel>(context, listen: false).addTodo(Provider.of<AppStateModel>(context, listen: false).label,newTodo);

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
  Provider.of<LocationTimeModel>(context, listen: false).addCity(Provider.of<AppStateModel>(context, listen: false).label,city);
  Provider.of<LocationTimeModel>(context, listen: false).addTime(Provider.of<AppStateModel>(context, listen: false).label,formattedTime);
}


@override
void initState() {
  super.initState();
  interstitialAdManager.interstitialAd();

}




  @override
  Widget build(BuildContext context) {
  return Consumer<AppStateModel>(
      builder: (context, appState, child) {
    if (Provider.of<AppStateModel>(context).isDataLoaded && (Provider.of<RandomWordsModel>(context).labeledLocations[Provider.of<AppStateModel>(context).label]??[]).isEmpty) {
      _loadAndPickRandomWord();
    }
  List<Picture> savedImages = imageService.getSavedImagesByLabel(Provider.of<AppStateModel>(context).label);
  List<String> locations = Provider.of<RandomWordsModel>(context).labeledLocations[Provider.of<AppStateModel>(context).label]??[];
  List<String> todos = Provider.of<RandomWordsModel>(context).labeledTodos[Provider.of<AppStateModel>(context).label]??[];
  List<String> citys = Provider.of<LocationTimeModel>(context).labeledCities[Provider.of<AppStateModel>(context).label]??[];
  List<String> times = Provider.of<LocationTimeModel>(context).labeledTimes[Provider.of<AppStateModel>(context).label]??[];
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
        child: Container(
          color: Theme.of(context).colorScheme.onBackground,
          child: ListView.builder(
          padding: EdgeInsets.only(bottom: 200.0,top: 50),
          itemCount: locations.length,
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
        ))),
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
  );}

}
