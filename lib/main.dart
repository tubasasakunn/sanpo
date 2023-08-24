import 'package:flutter/material.dart';
import 'package:sanpo/views/screens/random_item_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Item Picker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RandomItemDisplayScreen(jsonFileName: 'assets/data.json'),
    );
  }
}
