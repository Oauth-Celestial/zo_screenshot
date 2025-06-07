import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ZoCaptureAreaController {
  final GlobalKey captureKey = GlobalKey();

  Future<Uint8List?> capture() async {
    try {
      await WidgetsBinding.instance.endOfFrame;
      final boundary = captureKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Screenshot error: $e');
      return null;
    }
  }

  Future<void> captureAndShare({String fileName = 'widget_shot.png'}) async {
    final bytes = await capture();
    if (bytes == null) return;

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';
    final file = File(filePath)..writeAsBytesSync(bytes);

    await SharePlus.instance.share(
      ShareParams(text: 'Check out this widget!', files: [XFile(file.path)]),
    );
  }
}

class ZoCaptureArea extends StatelessWidget {
  final ZoCaptureAreaController controller;
  final Widget child;

  const ZoCaptureArea({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(key: controller.captureKey, child: child);
  }
}
