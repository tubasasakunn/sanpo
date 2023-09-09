import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomWordsModel extends ChangeNotifier {
  Map<String, List<String>> labeledLocations = {};
  Map<String, List<String>> labeledTodos = {};
  bool isDataLoaded = false;

  RandomWordsModel() {
    loadSavedData();
  }

Future<void> loadSavedData() async {
  final prefs = await SharedPreferences.getInstance();
  final decodedLocations = jsonDecode(prefs.getString('labeledLocations') ?? "{}") as Map<String, dynamic>;
  final decodedTodos = jsonDecode(prefs.getString('labeledTodos') ?? "{}") as Map<String, dynamic>;

  labeledLocations = decodedLocations.map((key, value) => MapEntry(key, List<String>.from(value)));
  labeledTodos = decodedTodos.map((key, value) => MapEntry(key, List<String>.from(value)));
  isDataLoaded = true;

  notifyListeners();
}

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('labeledLocations', jsonEncode(labeledLocations));
    prefs.setString('labeledTodos', jsonEncode(labeledTodos));
  }

  void addLocation(String label, String location) {
    if (!labeledLocations.containsKey(label)) {
      labeledLocations[label] = [];
    }
    labeledLocations[label]!.add(location);
    notifyListeners();
    saveData();
  }

  void addTodo(String label, String todo) {
    if (!labeledTodos.containsKey(label)) {
      labeledTodos[label] = [];
    }
    labeledTodos[label]!.add(todo);
    notifyListeners();
    saveData();
  }
}
