// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

enum NavigationStyle { namedRoute, classRoute }

class ZoNavigatorObserver extends NavigatorObserver {
  final NavigationStyle navigationStyle;
  List<String> secureNamedRouteList;

  List<Type> secureClassRouteList;
  ZoNavigatorObserver({
    required this.navigationStyle,
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
    if (navigationStyle == NavigationStyle.classRoute) {
      if (currentRoute is MaterialPageRoute) {
        final widget = currentRoute.builder(currentRoute.navigator!.context);
        if (secureClassRouteList.contains(widget.runtimeType)) {
          disableScreenshot();
        } else {
          enableScreenshot();
        }
      }
    }

    if (navigationStyle == NavigationStyle.namedRoute) {
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
    processRouteInfo(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    processRouteInfo(previousRoute);

    super.didPop(route, previousRoute);
  }
}
