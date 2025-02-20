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

    _zoScreenshotPlugin.startScreenshotListner(screenShotcallback: () {
      print("Screenshot taken");
    });
  }

  void enableScreenshot() {
    _zoScreenshotPlugin.enableScreenshot();
  }

  void disableScreenShot() {
    _zoScreenshotPlugin.disableScreenShot();
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
                disableScreenShot();
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
