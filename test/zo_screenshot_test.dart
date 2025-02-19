import 'package:flutter_test/flutter_test.dart';
import 'package:zo_screenshot/zo_screenshot.dart';
import 'package:zo_screenshot/zo_screenshot_platform_interface.dart';
import 'package:zo_screenshot/zo_screenshot_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZoScreenshotPlatform
    with MockPlatformInterfaceMixin
    implements ZoScreenshotPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ZoScreenshotPlatform initialPlatform = ZoScreenshotPlatform.instance;

  test('$MethodChannelZoScreenshot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZoScreenshot>());
  });

  test('getPlatformVersion', () async {
    ZoScreenshot zoScreenshotPlugin = ZoScreenshot();
    MockZoScreenshotPlatform fakePlatform = MockZoScreenshotPlatform();
    ZoScreenshotPlatform.instance = fakePlatform;

    expect(await zoScreenshotPlugin.getPlatformVersion(), '42');
  });
}
