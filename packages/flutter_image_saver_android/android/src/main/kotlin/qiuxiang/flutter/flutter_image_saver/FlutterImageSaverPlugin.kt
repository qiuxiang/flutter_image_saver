package qiuxiang.flutter.flutter_image_saver

import android.content.Context
import android.media.MediaScannerConnection
import android.os.Environment
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlutterImageSaverPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var context: Context
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "flutter_image_saver")
    channel.setMethodCallHandler(this)
    context = binding.applicationContext;
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPicturesDirectory" -> {
        result.success(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).path)
      }
      "scanFile" -> {
        MediaScannerConnection.scanFile(context, arrayOf(call.arguments()), arrayOf("image/png"), null)
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
