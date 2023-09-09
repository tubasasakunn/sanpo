import 'package:flutter/material.dart';
import 'package:sanpo/models/app_state.dart';
import 'package:sanpo/views/screens/multiple_image_screen.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final String label;

  CardWidget({required this.index, required this.label});

  @override
  Widget build(BuildContext context) {
return Card(
  elevation: 5.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  color: Theme.of(context).colorScheme.background,
  child: ListTile(
    contentPadding: EdgeInsets.all(16.0),
    title: Text(label, style: Theme.of(context).textTheme.labelMedium),
    onTap: () {
      Provider.of<AppStateModel>(context, listen: false).setIndex(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultipleImageScreen(),
        ),
      );
    },
    onLongPress: () async {
      TextEditingController _labelController = TextEditingController();
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ラベル名を変更"),
              content: TextField(
                controller: _labelController,
                decoration: InputDecoration(hintText: "新しいラベル名"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("キャンセル"),
                ),
                TextButton(
                  onPressed: () {
                    String newLabel = _labelController.text;
                    if (newLabel.isNotEmpty) {
                      Provider.of<AppStateModel>(context, listen: false).renameLabel(newLabel,index);
                    }
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          });
    },
  ),
);


  }
}