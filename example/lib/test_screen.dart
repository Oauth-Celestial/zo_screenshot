import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
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
      backgroundColor: Colors.red,
    );
  }
}
