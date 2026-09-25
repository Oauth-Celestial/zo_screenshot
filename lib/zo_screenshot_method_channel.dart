/// Method channel implementation of the zo_screenshot plugin.
library zo_screenshot_method_channel;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zo_screenshot/zo_screenshot_broadcaster.dart';

import 'zo_screenshot_platform_interface.dart';

/// An implementation of [ZoScreenshotPlatform] that uses method channels.
class MethodChannelZoScreenshot extends ZoScreenshotPlatform {
  /// Creates a [MethodChannelZoScreenshot] instance.
  MethodChannelZoScreenshot();

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zo_screenshot');

  @override
  void enableScreenshot() async {
    methodChannel.invokeMethod('enableScreenshot');
  }


  @override
  void disableScreenShot() {
    methodChannel.invokeMethod('disableScreenShot');
  }

  @override
  void startScreenshotListner() {
    methodChannel.invokeMethod('startListening');

    methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'onScreenshotTaken') {
        ZoScreenshotListnerBroadcaster().broadcastScreenshotTaken();
      }
    });
  }
}

