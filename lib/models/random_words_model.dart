import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomWordsModel extends ChangeNotifier {
  List<String> location = [];
  List<String> todo = [];

  RandomWordsModel() {
    loadSavedData();  // コンストラクタで保存されたデータを読み込む
  }

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    location = prefs.getStringList('location') ?? [];
    todo = prefs.getStringList('todo') ?? [];
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('location', location);
    await prefs.setStringList('todo', todo);
  }

  void addLocation(String loc) {
    location.add(loc);
    notifyListeners();
    saveData();  // データを追加した後に永続的に保存
  }

  void addTodo(String td) {
    todo.add(td);
    notifyListeners();
    saveData();  // データを追加した後に永続的に保存
  }
}
