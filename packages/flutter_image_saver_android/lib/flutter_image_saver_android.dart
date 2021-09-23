import 'package:flutter/services.dart';

final _channel = MethodChannel('flutter_image_saver');

/// Get the pictures directory of android external storage
Future<String> getPicturesDirectory() async {
  return await _channel.invokeMethod('getPicturesDirectory');
}

/// Notify android files changed
Future<void> scanFile(String path) async {
  return _channel.invokeMethod('scanFile', path);
}
