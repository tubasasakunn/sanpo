import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;


class ShareWidgetButton extends StatelessWidget {
  final GlobalKey globalKey;
  final Function toggleCaptureState;

  ShareWidgetButton({required this.globalKey,required this.toggleCaptureState});

  Future<void> shareWidgetImage(GlobalKey globalKey) async {
    toggleCaptureState();
    final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);  // <-- 修正
    
    final buffer = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/image.png');
    await file.writeAsBytes(buffer);

    await Share.shareFiles([file.path]);
    toggleCaptureState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        shareWidgetImage(globalKey);
      },
      tooltip: 'Share Widget',
      child: Icon(Icons.share),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

