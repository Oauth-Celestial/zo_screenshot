# zo_screenshot

[![pub package](https://img.shields.io/pub/v/zo_screenshot.svg)](https://pub.dev/packages/zo_screenshot)
[![pub points](https://img.shields.io/pub/points/zo_zo_screenshot?color=2E8B57&label=pub%20points)](https://pub.dev/packages/zo_screenshot)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

The zo_screenshot plugin helps restrict screenshots and screen recording in Flutter apps, enhancing security and privacy by preventing unauthorized screen captures.

## Getting started

First, add zo_screenshot as a dependency in your pubspec.yaml file

```yaml
dependencies:
  flutter:
    sdk: flutter
  zo_screenshot : ^[version]
```

## Import the package

```dart
import 'package:zo_screenshot/zo_screenshot.dart';
```

# Usage

### Disabling ScreenShot

```dart
final _zoScreenshotPlugin = ZoScreenshot();
_zoScreenshotPlugin.disableScreenShot();
```

**Enabling Screenshot**

```dart
final _zoScreenshotPlugin = ZoScreenshot();
_zoScreenshotPlugin.enableScreenshot();
```

**Listen To Screenshot Event**

```dart
final _zoScreenshotPlugin = ZoScreenshot();

_zoScreenshotPlugin.startScreenshotListner(
  screenShotcallback: () {
    print("Screenshot taken");
  },
);
```

Feel free to post a feature requests or report a bug [here](https://github.com/Oauth-Celestial/zo_screenshot/issues).

## My Other packages

- [zo_animated_border](https://pub.dev/packages/zo_animated_border): A package that provides a modern way to create gradient borders with animation in Flutter
- [connectivity_watcher](https://pub.dev/packages/connectivity_watcher): A Flutter package to monitor internet connectivity with subsecond response times, even on mobile networks.
- [ultimate_extension](https://pub.dev/packages/ultimate_extension): Enhances Dart collections and objects with utilities for advanced data manipulation and simpler coding.
- [theme_manager_plus](https://pub.dev/packages/theme_manager_plus): Allows customization of your app's theme with your own theme class, eliminating the need for traditional
- [date_util_plus](https://pub.dev/packages/date_util_plus): A powerful Dart API designed to augment and simplify date and time handling in your Dart projects.
- [pick_color](https://pub.dev/packages/pick_color): A Flutter package that allows you to extract colors and hex codes from images with a simple touch.
