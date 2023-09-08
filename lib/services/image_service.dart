import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import '../models/picture.dart';

class ImageService {
  static final ImageService _singleton = ImageService._internal();

  factory ImageService() {
    return _singleton;
  }

  ImageService._internal();

  List<Picture> savedImages = [];

// アプリ起動時に保存された画像をロード
Future<void> loadSavedImages() async {
  
  final dir = await getApplicationDocumentsDirectory();
  final imageDir = Directory('${dir.path}/saved_images/');
    if (!imageDir.existsSync()) {
    // ディレクトリが存在しない場合は作成
    imageDir.createSync(recursive: true);
  }

  final savedImagePaths = imageDir.listSync();
  for (var path in savedImagePaths) {
    if (path is File) {
      savedImages.add(Picture(File(path.path)));
    }
  }

}

  List<Picture> getSavedImages() {
    return savedImages;
  }

  Future<void> saveImage(Picture picture) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetPath = '${dir.path}/saved_images/${DateTime.now().toIso8601String()}.jpg';

    final targetDir = Directory('${dir.path}/saved_images');
    if (!targetDir.existsSync()) {
      targetDir.createSync();
    }

    await picture.image.copy(targetPath);
    savedImages.add(Picture(File(targetPath)));
    print("Image saved: $targetPath");
  }
}
