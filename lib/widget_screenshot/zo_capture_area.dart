/// Provides widget-level screenshot capture and sharing capabilities.
library zo_capture_area;

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Controller to programmatically capture and share widgets wrapped in a [ZoCaptureArea].
class ZoCaptureAreaController {
  /// Creates a new [ZoCaptureAreaController].
  ZoCaptureAreaController();

  /// The [GlobalKey] assigned to the repaint boundary of the capture area.
  final GlobalKey captureKey = GlobalKey();

  /// Captures the wrapped widget as an image and returns its PNG bytes as a [Uint8List].
  ///
  /// Returns `null` if the widget's render boundary cannot be found or if an error occurs.
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

  /// Captures the wrapped widget as a PNG image and opens the platform share sheet.
  ///
  /// [fileName] specifies the temporary file name used for saving and sharing the captured image.
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

/// A widget that wraps a [child] inside a [RepaintBoundary] to allow capturing it as an image via [controller].
class ZoCaptureArea extends StatelessWidget {
  /// The controller used to trigger captures and shares of this widget.
  final ZoCaptureAreaController controller;

  /// The widget tree to be captured.
  final Widget child;

  /// Creates a [ZoCaptureArea] widget.
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

