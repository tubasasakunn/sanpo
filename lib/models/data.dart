import 'dart:math';

class DataModel {
  final Map<String, dynamic> rawData;

  DataModel({required this.rawData});

  Tuple2<String, String> getNormalData() {
    final random = Random();
    final List<String> locations = List<String>.from(rawData['normal']['location']);
    final List<String> todos = List<String>.from(rawData['normal']['todo']);
    final randomLocation = locations[random.nextInt(locations.length)];
    final randomTodo = todos[random.nextInt(todos.length)];
    print("-------------------------------------");
    print(randomLocation);
    print("-------------------------------------");
    return Tuple2(randomLocation, randomTodo);
  }

  Tuple2<String, String> getHokkaidoData() {
    final random = Random();
    final List<String> locations = List<String>.from(rawData['todouhuken']['hokkaido']['location']);
    final List<String> todos = List<String>.from(rawData['todouhuken']['hokkaido']['todo']);
    final randomLocation = locations[random.nextInt(locations.length)];
    final randomTodo = todos[random.nextInt(todos.length)];
    return Tuple2(randomLocation, randomTodo);
  }

  // 他のモードに対応する関数をこちらに追加
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}
