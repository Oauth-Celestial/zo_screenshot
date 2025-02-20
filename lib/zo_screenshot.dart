import 'zo_screenshot_platform_interface.dart';

class ZoScreenshot {
  void enableScreenshot() {
    ZoScreenshotPlatform.instance.enableScreenshot();
  }

  void disableScreenShot() {
    ZoScreenshotPlatform.instance.disableScreenShot();
  }

  void startScreenshotListner({required Function screenShotcallback}) {
    ZoScreenshotPlatform.instance
        .startScreenshotListner(screenShotcallback: screenShotcallback);
  }
}
