import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sanpo/models/data.dart';
import 'package:sanpo/models/app_state.dart';

class DataService {
  DataModel? dataModel;

  Future<void> initialize(String fileName) async {
    if (dataModel == null) {
      final data = await rootBundle.loadString(fileName);
      final jsonResult = jsonDecode(data);
      dataModel = DataModel(rawData: jsonResult);
    }
  }

  Future<Tuple2<String, String>> loadRandomData(BuildContext context) async {
    final String mode = Provider.of<AppStateModel>(context, listen: false).mode;


    print("-------------------------------------");
    print(mode);
    print("-------------------------------------");

    if (dataModel == null) {

    print("-------------------------------------");
    print(mode);
    print("-------------------------------------");
      return Tuple2("", "");
    }

    print("-------------------------------------");
    print(dataModel);
    print("-------------------------------------");

    if (mode == "normal") {
      return dataModel!.getNormalData();
    } else if (mode == "hokkaido") {
      return dataModel!.getHokkaidoData();
    }
    // 他のモードに対応する処理をこちらに追加

    return Tuple2("", "");  // デフォルト、もしくはエラー処理
  }
}
