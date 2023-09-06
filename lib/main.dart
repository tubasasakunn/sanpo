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
        colorScheme: ColorScheme.light(
        primary:  Color(0xFFCCCCCC), // locationCardの背景
        secondary: Color(0xFFAAAAAA), //todoCardの背景
        background: Color(0xFF1498B2),
        onBackground: Color(0xFFFFFFFF),
        ),
  textTheme: TextTheme(
    labelMedium: TextStyle(color: Color(0xFFFFFFFF),fontFamily: 'QuickSand',
    fontWeight: FontWeight.bold,
    fontSize: 46), 
    labelSmall: TextStyle(color: Color(0xFFFFFFFF),fontFamily: 'QuickSand',
    fontWeight: FontWeight.bold,
    fontSize: 20), // 初期画面の選択肢
    bodyLarge: TextStyle(color: Color(0xFFFFFFFF),fontFamily: 'QuickSand',
    fontWeight: FontWeight.bold,
    fontSize: 24),
    bodyMedium: TextStyle(color: Color(0xFF1498B2),fontFamily: 'QuickSand',
    fontWeight: FontWeight.bold,
    fontSize: 16),
    bodySmall: TextStyle(color: Color(0xFF1498B2),fontFamily: 'QuickSand',
    fontWeight: FontWeight.bold,
    fontSize: 9),
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
        background: Color(0x1498B2),
        onBackground: Color(0x000000),
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
    backgroundColor: Theme.of(context).colorScheme.background,
    body: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleImageScreen(),
                    ),
                  );
                },
                child: Text('Start', style: Theme.of(context).textTheme.labelMedium),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.background,
                  elevation: 0.0,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {
              // onPressedは空白
            },
            child: Text('Reset', style: Theme.of(context).textTheme.labelSmall),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.background,
              elevation: 0.0,
            ),
          ),
        ),
      ],
    ),
  );
}
}