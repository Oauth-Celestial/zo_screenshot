import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ZoScreenShotWrapper(
        disableScreenShot: true,
        backgroundPreviewWidget: Container(
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
        ),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Example()),
      ),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final _zoScreenshotPlugin = ZoScreenshot();

  void enableScreenshot() {
    _zoScreenshotPlugin.enableScreenshot();
  }

  void disableScreenShot() {
    _zoScreenshotPlugin.disableScreenShot();
  }

  @override
  void initState() {
    // TODO: implement initState
    _zoScreenshotPlugin.startScreenshotListner(screenShotcallback: () {
      print("Screenshot taken");
    });
    super.initState();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 10,
          ),
          InkWell(
            onTap: () {
              _zoScreenshotPlugin.enableScreenshot();
              showSnackBar(context, "Screenshot enabled");
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
              showSnackBar(context, "Screenshot disabled");
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
    );
  }
}
