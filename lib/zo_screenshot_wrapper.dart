import 'package:flutter/material.dart';

class ZoScreenShotWrapper extends StatefulWidget {
  Widget child;
  Widget? backgroundPreviewWidget;
  ZoScreenShotWrapper(
      {super.key, required this.child, this.backgroundPreviewWidget});

  @override
  State<ZoScreenShotWrapper> createState() => _ZoScreenShotWrapperState();
}

class _ZoScreenShotWrapperState extends State<ZoScreenShotWrapper>
    with WidgetsBindingObserver {
  bool isBackground = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
        if (isBackground)
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
                child: Icon(Icons.remove_red_eye_rounded,
                    size: 50, color: Colors.white),
              ),
            )
          ]
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // app is in foreground
      isBackground = false;
      print("In Foreground");
    } else if (state == AppLifecycleState.inactive) {
      isBackground = true;
      print("In Background");
      // app is in background
    } else if (state == AppLifecycleState.paused) {
      isBackground = true;
      print("In Background");
    } else if (state == AppLifecycleState.detached) {
      isBackground = true;
      print("In Background");
      // app is detached
    }

    setState(() {});
  }
}
