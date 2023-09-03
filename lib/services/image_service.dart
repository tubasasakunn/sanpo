import 'dart:io';
import 'dart:async';
import '../models/picture.dart';

class ImageService {
    static final ImageService _singleton = ImageService._internal();

  factory ImageService() {
    return _singleton;
  }

  ImageService._internal();

  // 画像データを保存するためのダミーのリスト
  List<Picture> savedImages = [];
     // 保存された画像を取得するメソッド
  List<Picture> getSavedImages() {
    return savedImages;
  }

  // 画像を保存するメソッド
  Future<void> saveImage(Picture picture) async {
    // ここで実際の保存処理を行います。
    // データベースやファイルシステムへの保存など
    savedImages.add(picture);
    print("Image saved: ${picture.image.path}");
  }
}

