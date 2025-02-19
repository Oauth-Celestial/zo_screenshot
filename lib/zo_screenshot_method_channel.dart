import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zo_screenshot_platform_interface.dart';

/// An implementation of [ZoScreenshotPlatform] that uses method channels.
class MethodChannelZoScreenshot extends ZoScreenshotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zo_screenshot');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

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
}
