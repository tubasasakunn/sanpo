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

  Map<String, List<Picture>> savedImages = {};

  // アプリ起動時に保存された画像をロード
  Future<void> loadSavedImages() async {
    final dir = await getApplicationDocumentsDirectory();
    final baseDir = Directory('${dir.path}/saved_images/');

    if (!baseDir.existsSync()) {
      // ベースディレクトリが存在しない場合は作成
      baseDir.createSync(recursive: true);
    }

    List<FileSystemEntity> labels = baseDir.listSync();

    for (var label in labels) {
      
      if (label is Directory) {
        List<Picture> pictures = [];
        List<FileSystemEntity> files = label.listSync();
        for (var file in files) {
          if (file is File) {
            pictures.add(Picture(File(file.path)));
          }
        }
        savedImages[label.path.split("/").last] = pictures;

      }
    }
  }

  List<Picture> getSavedImagesByLabel(String label) {
    return savedImages[label] ?? [];
  }

  Future<void> saveImage( String label,Picture picture) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetDirPath = '${dir.path}/saved_images/$label';
    final targetDir = Directory(targetDirPath);

    if (!targetDir.existsSync()) {
      targetDir.createSync(recursive: true);
    }

    final targetPath = '$targetDirPath/${DateTime.now().toIso8601String()}.jpg';
    await picture.image.copy(targetPath);

    if (savedImages[label] == null) {
      savedImages[label] = [];
    }
    savedImages[label]?.add(Picture(File(targetPath)));
    print("Image saved: $targetPath");
  }
}
