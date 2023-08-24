import 'package:flutter/material.dart';
import 'package:sanpo/views/widgets/random_item_widget.dart';

class RandomItemDisplayScreen extends StatelessWidget {
  final String jsonFileName;

  RandomItemDisplayScreen({required this.jsonFileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Item Display'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RandomItemWidget(jsonFileName: jsonFileName),
        ),
      ),
    );
  }
}
