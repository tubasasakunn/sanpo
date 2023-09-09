import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateModel extends ChangeNotifier {
  List<String> labels = [];
  bool isDataLoaded = false;
  String label = "";
  String mode = "normal";

  AppStateModel() {
    print("app state ok");
  
  }

  void setIndex(int index) {
    label = labels[index];
    notifyListeners();
    saveData(); 
  }

  void renameLabel(String newLabel,int index){
    labels[index]=newLabel;
    notifyListeners();
    saveData();
  }


  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final decodedLabels = jsonDecode(prefs.getString('labels') ?? '["1"]') as List<dynamic>;

    labels = List<String>.from(decodedLabels);
    isDataLoaded = true;
    label=prefs.getString('label') ?? labels[0];
    mode = prefs.getString('mode') ?? "normal";


    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('labels', jsonEncode(labels));
    prefs.setString('label', label);
    prefs.setString('mode', mode);
  }

  void addLabel(String newLabel) {
    labels.add(newLabel);
    label=newLabel;
    notifyListeners();
    saveData();
  }


    void addLabelPuls1() {
    String newLabel = "さんぽ"+labels.length.toString();
    labels.add(newLabel);
    label=newLabel;
    notifyListeners();
    saveData();
  }

  void removeLabel(String labelToRemove) {
    labels.remove(labelToRemove);
    notifyListeners();
    saveData();
  }
}
