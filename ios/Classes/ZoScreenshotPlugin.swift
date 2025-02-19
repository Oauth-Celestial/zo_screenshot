import Flutter
import UIKit
import ScreenProtectorKit

public class ZoScreenshotPlugin: NSObject, FlutterPlugin {
    
    static  var screenShotHandler:ScreenProtectorKit? = nil
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zo_screenshot", binaryMessenger: registrar.messenger())
    let instance = ZoScreenshotPlugin()
      
      var window:UIWindow? = UIApplication.shared.delegate?.window as? UIWindow
      
      if(window != nil){
          screenShotHandler = ScreenProtectorKit(window: window)
          screenShotHandler?.configurePreventionScreenshot()
      }
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
        
    case "enableScreenshot":
        ZoScreenshotPlugin.enableScreenShot(result: result)
    case "disableScreenShot":
        ZoScreenshotPlugin.disableScreenShot(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
    private static func enableScreenShot(result: @escaping FlutterResult){
        screenShotHandler?.disablePreventScreenshot()
        
        result(nil)
    }
    
    private static func disableScreenShot(result: @escaping FlutterResult){
        screenShotHandler?.enabledPreventScreenshot()
        result(nil)
    }

}
