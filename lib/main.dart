import 'package:flutter/material.dart';
import 'package:sanpo/views/screens/multiple_image_screen.dart';  // 追加
import 'package:provider/provider.dart';
import 'package:sanpo/models/random_words_model.dart';
import 'package:sanpo/models/location_time_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RandomWordsModel()),
        ChangeNotifierProvider(create: (context) => LocationTimeModel()),
      ],
      child: MyApp(),
    ),
  );
}


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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              child: Text('すたーと'),  // 追加
            ),
          ],
        ),
      ),
    );
  }
}
