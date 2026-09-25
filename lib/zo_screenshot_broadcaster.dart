/// Broadcaster service providing streams for screenshot events across the application.
library zo_screenshot_broadcaster;

import 'dart:async';

/// A singleton broadcaster stream controller that notifies listeners when a screenshot event is triggered.
class ZoScreenshotListnerBroadcaster {
  ZoScreenshotListnerBroadcaster._();

  static final ZoScreenshotListnerBroadcaster _instance =
      ZoScreenshotListnerBroadcaster._();

  /// Returns the singleton instance of [ZoScreenshotListnerBroadcaster].
  factory ZoScreenshotListnerBroadcaster() => _instance;

  final StreamController<bool> _screenshotTakenController =
      StreamController<bool>.broadcast();

  /// Stream of screenshot event notifications.
  Stream<bool> get onScreenshotTaken => _screenshotTakenController.stream;

  /// Broadcasts a screenshot notification event to all active stream listeners.
  void broadcastScreenshotTaken() {
    _screenshotTakenController.add(true);
  }
}

