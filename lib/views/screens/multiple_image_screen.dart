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
import '../../models/random_words_model.dart'; // ここでRandomWordsModelをインポート
import '../../models/location_time_model.dart';
import '../../models/app_state.dart';
import 'package:location/location.dart' as loc; // 位置情報を取得するためのパッケージ
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import '../widgets/interstitial_ad_manager.dart';

class MultipleImageScreen extends StatefulWidget {
  @override
  _MultipleImageScreenState createState() => _MultipleImageScreenState();
}

class _MultipleImageScreenState extends State<MultipleImageScreen> {
  File? _image;
  int count = 0; // 追加: count変数
  final picker = ImagePicker();
  final imageService = ImageService();
  final GlobalKey _globalKey = GlobalKey();
  final InterstitialAdManager interstitialAdManager = InterstitialAdManager();

  // ダミーデータのリスト（実際には適切なデータを設定してください）
  List<String> dummyLocations = ['川沿いを歩きながら', '夜の街を歩きながら', '古い鉄道の脇を歩いて','郊外の田舎道で'];
  List<String> dummyTodos = ['顔に見えるものを探そう', '自分の影を見つけよう', '自分の足跡を見よう','ポケットに何があるか確認'];
  List<String> dummyCitys = ['k','日光市', '横浜市', '舞鶴市'];
  List<String> dummytimes = ['k','12:30', '19:42', '16:32'];

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(
            Provider.of<AppStateModel>(context, listen: false).label,
            Picture(_image!));
        _loadAndPickRandomWord(dummyLocations[count], dummyTodos[count]);
        _getCurrentLocationAndTime(dummyCitys[count],dummytimes[count]); // ダミーデータから取得
        interstitialAdManager.showInterstitialAd();
      }
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageService.saveImage(
            Provider.of<AppStateModel>(context, listen: false).label,
            Picture(_image!));
        _loadAndPickRandomWord(dummyLocations[count], dummyTodos[count]); // ダミーデータから取得
        _getCurrentLocationAndTime(dummyCitys[count],dummytimes[count]); // ダミーデータから取得
        interstitialAdManager.showInterstitialAd();
        count++; // countをインクリメント
      }
    });
  }

  Future<void> _loadAndPickRandomWord(String newLocation, String newTodo) async {
    Provider.of<RandomWordsModel>(context, listen: false).addLocation(
        Provider.of<AppStateModel>(context, listen: false).label, newLocation);
    Provider.of<RandomWordsModel>(context, listen: false).addTodo(
        Provider.of<AppStateModel>(context, listen: false).label, newTodo);
  }

  Future<void> _getCurrentLocationAndTime(city,formattedTime) async {
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
      _loadAndPickRandomWord(dummyLocations[count], dummyTodos[count]);
      count++; // countをインクリメント
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
    body: Column(
  children: [SizedBox(height: 60),
    Expanded(
      child: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Theme.of(context).colorScheme.onBackground,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 200.0),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              if (index == locations.length - 1 && !isCapturingImage) {
                return RandomWordsCard(
                    todo: todos[index], location: locations[index]);
              }

              return RandomWordsAndImage(
                location: locations[index],
                todo: todos[index],
                image: index < savedImages.length ? savedImages[index].image : null,
                time: index < times.length ? times[index] : null,
                city: index < citys.length ? citys[index] : null,
              );
            },
          ),
        ),
      ),
    ),
    
  ],
)
,
    
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
