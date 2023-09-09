import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sanpo/views/screens/multiple_image_screen.dart';  // 追加
import 'package:sanpo/views/screens/history_screen.dart';
import 'package:provider/provider.dart';
import 'package:sanpo/models/random_words_model.dart';
import 'package:sanpo/models/location_time_model.dart';
import 'package:sanpo/models/app_state.dart';
import 'package:sanpo/services/image_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
  final imageService = ImageService();
  await imageService.loadSavedImages();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RandomWordsModel()),
        ChangeNotifierProvider(create: (context) => LocationTimeModel()),
        ChangeNotifierProvider(create: (context) => AppStateModel()),
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
      home: FutureBuilder(
        // アプリの状態モデルのloadSavedDataメソッドを呼び出す
        future: initializeApp(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // データがロード中の場合、ローディング画面を表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();  // 任意のローディング画面
          }
          // エラーが発生した場合、エラー画面を表示
          if (snapshot.hasError) {
            return Container();  // 任意のエラー画面
          }
          // データがロードされた場合、ホーム画面を表示
          return HomeScreen();
        }),
    );
  }
}

Future<void> initializeApp(BuildContext context) async {
  try{
  await Future.wait([
    Provider.of<AppStateModel>(context, listen: false).loadSavedData(),
    Provider.of<RandomWordsModel>(context, listen: false).loadSavedData(),
    Provider.of<LocationTimeModel>(context, listen: false).loadSavedData(),
  ]);
  }catch(e){
    print("errrr $e");
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
             SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<AppStateModel>(context,listen: false).addLabelPuls1();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultipleImageScreen(),
                    ),
                  );
                },
                child: Text('New', style: Theme.of(context).textTheme.labelMedium),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.background,
                  elevation: 0.0,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(),
                    ),
                  );
                },
                child: Text('History', style: Theme.of(context).textTheme.labelMedium),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.background,
                  elevation: 0.0,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
}