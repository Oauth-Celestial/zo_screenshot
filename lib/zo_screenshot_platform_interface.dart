/// Common platform interface for the zo_screenshot plugin.
library zo_screenshot_platform_interface;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zo_screenshot_method_channel.dart';

abstract class ZoScreenshotPlatform extends PlatformInterface {
  /// Constructs a ZoScreenshotPlatform.
  ZoScreenshotPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZoScreenshotPlatform _instance = MethodChannelZoScreenshot();

  /// The default instance of [ZoScreenshotPlatform] to use.
  ///
  /// Defaults to [MethodChannelZoScreenshot].
  static ZoScreenshotPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZoScreenshotPlatform] when
  /// they register themselves.
  static set instance(ZoScreenshotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Enables screenshots on the platform.
  void enableScreenshot() {
    throw UnimplementedError('enableScreenshot() has not been implemented.');
  }

  /// Disables screenshots on the platform.
  void disableScreenShot() {
    throw UnimplementedError('disableScreenShot() has not been implemented.');
  }

  /// Starts listening for platform screenshot notifications.
  void startScreenshotListner() {
    throw UnimplementedError(
        'startScreenshotListner() has not been implemented.');
  }
}

