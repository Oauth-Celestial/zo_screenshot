/// Provides the [ZoNavigatorObserver] to automatically manage screenshot protection per route.
library zo_navigator_observer;

import 'package:flutter/material.dart';
import 'package:zo_screenshot/zo_screenshot.dart';

/// Style of navigation routing used to determine secure screens.
enum NavigationStyle {
  /// Routes identified by their route name (e.g. `'/home'`).
  namedRoute,

  /// Routes identified by their runtime widget Type.
  classRoute,
}

/// A [NavigatorObserver] that automatically enables or disables screenshot protection based on current routes.
class ZoNavigatorObserver extends NavigatorObserver {
  /// The navigation style used to evaluate routes.
  final NavigationStyle navigationStyle;

  /// List of named route strings where screenshots should be blocked.
  List<String> secureNamedRouteList;

  /// List of widget [Type]s where screenshots should be blocked.
  List<Type> secureClassRouteList;

  /// Creates a [ZoNavigatorObserver] to monitor navigation changes and manage screenshot protection.
  ZoNavigatorObserver({
    required this.navigationStyle,
    this.secureNamedRouteList = const [],
    this.secureClassRouteList = const [],
  });

  /// Disables screenshot capture on the platform.
  void disableScreenshot() {
    ZoScreenshot().disableScreenShot();
  }

  /// Enables screenshot capture on the platform.
  void enableScreenshot() {
    ZoScreenshot().enableScreenshot();
  }

  /// Processes the [currentRoute] to enable or disable screenshot capture based on configuration.
  void processRouteInfo(Route? currentRoute) {

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
