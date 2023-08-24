import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sanpo/models/data.dart';
import 'package:sanpo/services/data_service.dart';

class RandomItemWidget extends StatefulWidget {
  final String jsonFileName;

  RandomItemWidget({required this.jsonFileName});

  @override
  _RandomItemWidgetState createState() => _RandomItemWidgetState();
}

class _RandomItemWidgetState extends State<RandomItemWidget> {
  String? selectedLocation;
  String? selectedTodo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(selectedLocation ?? 'Press the button to pick a location!'),
        Text(selectedTodo ?? 'Press the button to pick a todo!'),
        ElevatedButton(
          onPressed: _loadAndPickRandomItems,
          child: Text('Pick Random Items'),
        ),
      ],
    );
  }

  Future<void> _loadAndPickRandomItems() async {
    final items = await DataService().loadData(widget.jsonFileName);
    setState(() {
      selectedLocation = items.location[Random().nextInt(items.location.length)];
      selectedTodo = items.todo[Random().nextInt(items.todo.length)];
    });
  }
}
