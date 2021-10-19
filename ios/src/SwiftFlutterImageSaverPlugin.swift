import Flutter
import UIKit

public class SwiftFlutterImageSaverPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_image_saver", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterImageSaverPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method) {
    case "saveImage":
      if let it = call.arguments as? FlutterStandardTypedData {
        let image = UIImage(data: Data([UInt8](it.data)))
        if (image != nil) {
          UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
      }
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
