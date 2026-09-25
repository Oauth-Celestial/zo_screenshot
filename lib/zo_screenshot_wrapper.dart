/// Provides the [ZoScreenShotWrapper] widget for protecting UI screens against screenshots and background previews.
library zo_screenshot_wrapper;

import 'package:flutter/material.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

/// A wrapper widget that provides screenshot protection and handles background privacy previews.
class ZoScreenShotWrapper extends StatefulWidget {
  /// The primary widget tree wrapped by this protection layer.
  final Widget child;

  /// Custom widget to display when the app is in the background or app switcher.
  ///
  /// If `null`, a default privacy lock screen with a lock icon is displayed.
  final Widget? backgroundPreviewWidget;

  /// Whether to disable screenshots on initialization.
  final bool? disableScreenShot;

  /// Whether to show the background privacy preview when the app enters the background.
  ///
  /// Defaults to `true`.
  final bool? showBackgroundPreview;

  /// Creates a [ZoScreenShotWrapper] widget.
  const ZoScreenShotWrapper(
      {super.key,
      required this.child,
      this.backgroundPreviewWidget,
      this.disableScreenShot,
      this.showBackgroundPreview = true});


  @override
  State<ZoScreenShotWrapper> createState() => _ZoScreenShotWrapperState();
}

class _ZoScreenShotWrapperState extends State<ZoScreenShotWrapper>
    with WidgetsBindingObserver {
  bool isBackground = false;
  bool hasTakenScreenShot = false;

  @override
  void initState() {
    if (widget.disableScreenShot ?? false) {
      ZoScreenshot().disableScreenShot();
    }
    if (widget.showBackgroundPreview ?? false) {
      WidgetsBinding.instance.addObserver(this);
      ZoScreenshot().startScreenshotListner(screenShotcallback: () {
        hasTakenScreenShot = true;
        print("Listener called in wrapper");
        setState(() {});
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (isBackground && !hasTakenScreenShot)
          if (widget.backgroundPreviewWidget != null) ...[
            widget.backgroundPreviewWidget!
          ] else ...[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[300]!, Colors.grey]),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Icon(Icons.lock, size: 50, color: Colors.white),
              ),
            )
          ]
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      isBackground = false;
      hasTakenScreenShot = false;
    } else if (state == AppLifecycleState.inactive) {
      isBackground = true;
    } else if (state == AppLifecycleState.paused) {
      isBackground = true;
    } else if (state == AppLifecycleState.detached) {
      isBackground = true;
    }

    setState(() {});
  }
}
