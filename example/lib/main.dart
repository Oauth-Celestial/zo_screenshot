import 'package:flutter/material.dart';
import 'dart:async';

import 'package:zo_screenshot/zo_screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _zoScreenshotPlugin = ZoScreenshot();

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _zoScreenshotPlugin.startScreenshotListner(screenShotcallback: () {
      print("Screenshot taken");
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            InkWell(
              onTap: () {
                _zoScreenshotPlugin.enableScreenshot();
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("enableScreenshot"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _zoScreenshotPlugin.disableScreenShot();
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("disableScreenshot"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
