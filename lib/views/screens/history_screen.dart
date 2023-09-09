import 'package:flutter/material.dart';
import 'package:sanpo/models/app_state.dart';
import 'package:sanpo/views/widgets/card_widget.dart';
import 'package:provider/provider.dart';


class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppStateModel>(
        builder: (context, appState, child) {
          return ListView.builder(
            itemCount: appState.labels.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
CardWidget(index: index, label: appState.labels[index]),
SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }
}


