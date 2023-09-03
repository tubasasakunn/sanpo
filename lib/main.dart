import 'package:flutter/material.dart';
import 'package:sanpo/views/screens/random_item_picker.dart';
import 'package:sanpo/views/screens/image_picker_screen.dart';
import 'package:sanpo/views/screens/multiple_image_screen.dart';  // 追加

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Item Picker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Item Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RandomItemDisplayScreen(jsonFileName: 'assets/data.json'),
                  ),
                );
              },
              child: Text('Random Item Picker'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePickerScreen(),
                  ),
                );
              },
              child: Text('Image Picker Screen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultipleImageScreen(),  // 追加
                  ),
                );
              },
              child: Text('Multiple Image Screen'),  // 追加
            ),
          ],
        ),
      ),
    );
  }
}
