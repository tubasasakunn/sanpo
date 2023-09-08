import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationTimeModel extends ChangeNotifier {
  List<String> city = [];
  List<String> time = [];

  LocationTimeModel() {
    loadSavedData();  // コンストラクタで保存されたデータを読み込む
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    city = prefs.getStringList('city') ?? [];
    time = prefs.getStringList('time') ?? [];
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('city', city);
    await prefs.setStringList('time', time);
  }

  void addCity(String ct) {
    city.add(ct);
    notifyListeners();
    saveData();  // データを追加した後で永続的に保存
  }

  void addTime(String tm) {
    time.add(tm);
    notifyListeners();
    saveData();  // データを追加した後で永続的に保存
  }
}
