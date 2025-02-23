import 'package:flutter/material.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

class ZoScreenShotWrapper extends StatefulWidget {
  final Widget child;
  final Widget? backgroundPreviewWidget;
  final bool? disableScreenShot;
  final bool? showBackgroundPreview;

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
      print("inactive");
    } else if (state == AppLifecycleState.paused) {
      isBackground = true;
      print("paused");
    } else if (state == AppLifecycleState.detached) {
      isBackground = true;
      print("detached");
    }

    setState(() {});
  }
}
