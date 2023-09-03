import 'package:flutter/material.dart';

class RandomWordsModel extends ChangeNotifier {
  List<String> location = [];
  List<String> todo = [];

  void addLocation(String loc) {
    location.add(loc);
    notifyListeners();
  }

  void addTodo(String td) {
    todo.add(td);
    notifyListeners();
  }
}
