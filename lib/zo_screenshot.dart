export 'zo_screenshot_wrapper.dart';

export 'observer/zo_navigator_observer.dart';

import 'package:zo_screenshot/zo_screenshot_broadcaster.dart';

import 'zo_screenshot_platform_interface.dart';

class ZoScreenshot {
  void enableScreenshot() {
    ZoScreenshotPlatform.instance.enableScreenshot();
  }

  void disableScreenShot() {
    ZoScreenshotPlatform.instance.disableScreenShot();
  }

  void startScreenshotListner({required Function screenShotcallback}) {
    ZoScreenshotPlatform.instance.startScreenshotListner();
    ZoScreenshotListnerBroadcaster().onScreenshotTaken.listen((value) {
      screenShotcallback();
    });
  }
}
