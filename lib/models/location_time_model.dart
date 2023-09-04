import 'package:flutter/foundation.dart';

class LocationTimeModel extends ChangeNotifier {
  List<String> city = [];
  List<String> time = [];

  void addCity(String ct) {
    city.add(ct);
    notifyListeners();
  }

  void addTime(String tm) {
    time.add(tm);
    notifyListeners();
  }
}
