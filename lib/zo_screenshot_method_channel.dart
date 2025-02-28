import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zo_screenshot/zo_screenshot_broadcaster.dart';

import 'zo_screenshot_platform_interface.dart';

/// An implementation of [ZoScreenshotPlatform] that uses method channels.
class MethodChannelZoScreenshot extends ZoScreenshotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zo_screenshot');

  @override
  void enableScreenshot() async {
    // TODO: implement enableScreenshot

    methodChannel.invokeMethod('enableScreenshot');
  }

  @override
  void disableScreenShot() {
    // TODO: implement disableScreenShot
    methodChannel.invokeMethod('disableScreenShot');
  }

  @override
  void startScreenshotListner() {
    // TODO: implement startScreenshotListner

    methodChannel.invokeMethod('startListening');

    methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'onScreenshotTaken') {
        ZoScreenshotListnerBroadcaster().broadcastScreenshotTaken();
        // screenShotcallback();
      }
    });
  }
}
