import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationTimeModel extends ChangeNotifier {
  Map<String, List<String>> labeledCities = {};
  Map<String, List<String>> labeledTimes = {};

  LocationTimeModel() {
    loadSavedData();
  }

Future<void> loadSavedData() async {
  final prefs = await SharedPreferences.getInstance();
  final decodedCities = jsonDecode(prefs.getString('labeledCities') ?? "{}") as Map<String, dynamic>;
  final decodedTimes = jsonDecode(prefs.getString('labeledTimes') ?? "{}") as Map<String, dynamic>;

  labeledCities = decodedCities.map((key, value) => MapEntry(key, List<String>.from(value)));
  labeledTimes = decodedTimes.map((key, value) => MapEntry(key, List<String>.from(value)));

  notifyListeners();
}


  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('labeledCities', jsonEncode(labeledCities));
    prefs.setString('labeledTimes', jsonEncode(labeledTimes));
  }

  void addCity(String label, String city) {
    if (!labeledCities.containsKey(label)) {
      labeledCities[label] = [];
    }
    labeledCities[label]!.add(city);
    notifyListeners();
    saveData();
  }

  void addTime(String label, String time) {
    if (!labeledTimes.containsKey(label)) {
      labeledTimes[label] = [];
    }
    labeledTimes[label]!.add(time);
    notifyListeners();
    saveData();
  }
}
