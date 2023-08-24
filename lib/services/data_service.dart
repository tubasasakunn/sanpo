import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sanpo/models/data.dart';

class DataService {
  Future<DataModel> loadData(String fileName) async {
    final data = await rootBundle.loadString(fileName);
    final jsonResult = jsonDecode(data);
    return DataModel.fromJson(jsonResult);
  }
}
