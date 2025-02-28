import 'dart:async';

class ZoScreenshotListnerBroadcaster {
  ZoScreenshotListnerBroadcaster._();

  static final ZoScreenshotListnerBroadcaster _instance =
      ZoScreenshotListnerBroadcaster._();

  factory ZoScreenshotListnerBroadcaster() => _instance;

  final StreamController<bool> _screenshotTakenController =
      StreamController<bool>.broadcast();

  Stream<bool> get onScreenshotTaken => _screenshotTakenController.stream;

  void broadcastScreenshotTaken() {
    _screenshotTakenController.add(true);
  }
}
