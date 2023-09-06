import 'package:flutter/material.dart';

class ShowPickerOptions extends StatelessWidget {
  final Future<void> Function() getImageFromCamera;
  final Future<void> Function() getImageFromGallery;

  ShowPickerOptions({
    required this.getImageFromCamera,
    required this.getImageFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Take a photo'),
                    onTap: () {
                      Navigator.pop(context);
                      getImageFromCamera();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      getImageFromGallery();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      tooltip: 'Pick Image',
      child: Icon(Icons.add_a_photo, color: Theme.of(context).colorScheme.onBackground,),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
