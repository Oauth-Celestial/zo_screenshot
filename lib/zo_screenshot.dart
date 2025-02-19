import 'zo_screenshot_platform_interface.dart';

class ZoScreenshot {
  Future<String?> getPlatformVersion() {
    return ZoScreenshotPlatform.instance.getPlatformVersion();
  }

  void enableScreenshot() {
    ZoScreenshotPlatform.instance.enableScreenshot();
  }

  void disableScreenShot() {
    ZoScreenshotPlatform.instance.disableScreenShot();
  }
}
