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
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Item Picker',
      theme: ThemeData(
        brightness: Brightness.light,
  backgroundColor: Color(0xFFFFFFFF), // 背景色
        colorScheme: ColorScheme.light(
        primary:  Color(0xFFCCCCCC), // locationCardの背景
        secondary: Color(0xFFAAAAAA), //todoCardの背景
        ),
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Color(0xFF666666)), // 初期画面の選択肢
    bodyMedium: TextStyle(color: Color(0xFF666666)), // カードの文字
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFFE0E0E0), // ボタンの背景色
    ),
  ),
),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
  backgroundColor: Color(0xFF000000), 
        colorScheme: ColorScheme.dark(
        primary:  Color(0xFF666666), 
        secondary: Color(0xFF999999),
        ),
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Color(0xFFAAAAAA)),
    bodyMedium: TextStyle(color: Color(0xFF666666)), 
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF333333), // ボタンの背景色
    ),
  ),
),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
              child: Text('すたーと',style: Theme.of(context).textTheme.bodySmall,),  // 追加
            ),
          ],
        ),
      ),
    );
  }
}
