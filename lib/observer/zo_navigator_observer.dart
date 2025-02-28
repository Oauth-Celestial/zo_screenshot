// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

class ZoNavigatorObserver extends NavigatorObserver {
  bool isNamedRouteStyle;

  bool isClassRouteStyle;

  List<String> secureNamedRouteList;

  List<Type> secureClassRouteList;
  ZoNavigatorObserver({
    this.isNamedRouteStyle = false,
    this.isClassRouteStyle = false,
    this.secureNamedRouteList = const [],
    this.secureClassRouteList = const [],
  });

  disableScreenshot() {
    ZoScreenshot().disableScreenShot();
  }

  enableScreenshot() {
    ZoScreenshot().enableScreenshot();
  }

  processRouteInfo(Route? currentRoute) {
    if (isClassRouteStyle) {
      if (currentRoute is MaterialPageRoute) {
        final widget = currentRoute.builder(currentRoute.navigator!.context);
        if (secureClassRouteList.contains(widget.runtimeType)) {
          disableScreenshot();
        } else {
          enableScreenshot();
        }
      }
    }

    if (isNamedRouteStyle) {
      if (currentRoute?.settings.name != null) {
        if (secureNamedRouteList.contains(currentRoute?.settings.name)) {
          disableScreenshot();
        } else {
          enableScreenshot();
        }
      }
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    processRouteInfo(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop

    processRouteInfo(previousRoute);

    super.didPop(route, previousRoute);
  }
}
