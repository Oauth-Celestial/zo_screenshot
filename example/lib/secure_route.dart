import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

class SecureRoute extends StatefulWidget {
  const SecureRoute({super.key});

  @override
  State<SecureRoute> createState() => _SecureRouteState();
}

class _SecureRouteState extends State<SecureRoute> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ZoScreenshot().startScreenshotListner(screenShotcallback: () {
      print("Taken on Test Screen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Text(" Secure Route"),
      ),
    );
  }
}
