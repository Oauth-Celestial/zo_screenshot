package com.zerone.zo_screenshot

import android.app.Activity
import android.database.ContentObserver
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import android.util.Log
import android.view.WindowManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ZoScreenshotPlugin */
class ZoScreenshotPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zo_screenshot")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {


    when(call.method){


      "enableScreenshot" -> {
        enableScreenShot(result)
      }

      "disableScreenShot" -> {
        disableScreenShot(result)
      }

      "startListening" -> {
          startScreenshotListener()
      }


      else -> result.notImplemented()
    }


  }


 private fun enableScreenShot(result: Result){

   activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
   result.success(null)
  }

  private fun disableScreenShot(result: Result){

    activity?.window?.setFlags(
      WindowManager.LayoutParams.FLAG_SECURE,
      WindowManager.LayoutParams.FLAG_SECURE
    )
    result.success(null)
  }



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {

    // As we are not using  flutter activity we have to inherit the activity aware class
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

    private fun startScreenshotListener() {
        val observer = object : ContentObserver(Handler(Looper.getMainLooper())) {
            override fun onChange(selfChange: Boolean) {
                Log.d("Screenshot", "Screenshot detected!")
                try{
                activity?.runOnUiThread {
                    channel
                        .invokeMethod("onScreenshotTaken", null)
                }}
                catch (e : Exception){
                    Log.d("Screenshot", e.message!!)
                }

            }
        }
       activity?.contentResolver?.registerContentObserver(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, true, observer)
    }
}
