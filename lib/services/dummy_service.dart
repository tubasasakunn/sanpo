import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sanpo/services/image_service.dart';
import 'package:sanpo/models/picture.dart';
import 'package:sanpo/models/random_words_model.dart';
import 'package:sanpo/models/location_time_model.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';



class DummyDataService {
  ImageService _imageService = ImageService();
  RandomWordsModel _randomWordsModel = RandomWordsModel();
  LocationTimeModel _locationTimeModel = LocationTimeModel();

Future<void> addDummyImage() async {
    // アセットからByteDataを取得
    final ByteData data = await rootBundle.load('assets/icon/icon.png');
    final List<int> bytes = data.buffer.asUint8List();
    
    // 一時ディレクトリに画像を保存
    final String tempPath = (await getTemporaryDirectory()).path;
    final String filePath = '$tempPath/dummy_image.png';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);

    // 画像をImageServiceに保存
    await _imageService.saveImage('dummyLabel', Picture(file));
}



  void addDummyRandomWords() {
    // ダミーデータの追加
    _randomWordsModel.addLocation('dummyLabel', 'DummyLocation');
    _randomWordsModel.addTodo('dummyLabel', 'DummyTodo');
  }

  void addDummyLocationTime() {
    // ダミーデータの追加
    _locationTimeModel.addCity('dummyLabel', 'DummyCity');
    _locationTimeModel.addTime('dummyLabel', '12:34');
  }

  Future<void> addAllDummyData() async {
    await addDummyImage();
    addDummyRandomWords();
    addDummyLocationTime();
  }
}

// 使用例
// DummyDataService dummyDataService = DummyDataService();
// await dummyDataService.addAllDummyData();
