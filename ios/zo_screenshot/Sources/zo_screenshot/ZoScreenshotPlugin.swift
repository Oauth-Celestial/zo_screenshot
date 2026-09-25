import Flutter
import UIKit
import ScreenProtectorKit

public class ZoScreenshotPlugin: NSObject, FlutterPlugin {
    
    static  var screenShotHandler:ScreenProtectorKit? = nil
    
    var methodChannel:FlutterMethodChannel? = nil
    
    init(methodChannel: FlutterMethodChannel? = nil) {
        self.methodChannel = methodChannel
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zo_screenshot", binaryMessenger: registrar.messenger())
      let instance = ZoScreenshotPlugin(methodChannel: channel)
      
      var window:UIWindow? = UIApplication.shared.delegate?.window as? UIWindow
      
      if(window != nil){
          screenShotHandler = ScreenProtectorKit(window: window)
          screenShotHandler?.configurePreventionScreenshot()
      }
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "enableScreenshot":
        ZoScreenshotPlugin.enableScreenShot(result: result)
    case "disableScreenShot":
        ZoScreenshotPlugin.disableScreenShot(result: result)
        
    case "startListening":
        startScreenShotListner()
        result(nil)
    
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
    
    func startScreenShotListner(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        
    }
    
    
    @objc func screenshotTaken() {
        var window:UIWindow? = UIApplication.shared.delegate?.window as? UIWindow
           let controller = window?.rootViewController as! FlutterViewController
         
        methodChannel?.invokeMethod("onScreenshotTaken", arguments: nil)
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
