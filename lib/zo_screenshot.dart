/// A Flutter plugin to block screenshots and screen recording for privacy, while allowing secure screenshot capture of specific widgets.
library zo_screenshot;

export 'zo_screenshot_wrapper.dart';

export 'observer/zo_navigator_observer.dart';

export 'widget_screenshot/zo_capture_area.dart';

import 'package:zo_screenshot/zo_screenshot_broadcaster.dart';

import 'zo_screenshot_platform_interface.dart';

/// The main interface for managing screenshot prevention and listening for screenshot events.
class ZoScreenshot {
  /// Creates a [ZoScreenshot] instance.
  ZoScreenshot();

  /// Enables screenshots and screen recording on the current screen.
  void enableScreenshot() {
    ZoScreenshotPlatform.instance.enableScreenshot();
  }

  /// Disables screenshots and screen recording on the current screen.
  void disableScreenShot() {
    ZoScreenshotPlatform.instance.disableScreenShot();
  }

  /// Starts listening for native screenshot events.
  ///
  /// [screenShotcallback] is invoked whenever a screenshot attempt or capture is detected.
  void startScreenshotListner({required Function screenShotcallback}) {
    ZoScreenshotPlatform.instance.startScreenshotListner();
    ZoScreenshotListnerBroadcaster().onScreenshotTaken.listen((value) {
      screenShotcallback();
    });
  }
}

