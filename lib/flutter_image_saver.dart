import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';

final _channel = MethodChannel('flutter_image_saver');

/// 图片数据另存为文件
///
/// 桌面版默认保存到下载目录，android 默认保存到 Pictures 目录，web 版则是作为文件下载
Future<String> saveImage({
  /// 图片数据
  required Uint8List data,

  /// 保存的文件名
  required String filename,
}) async {
  final file = XFile.fromData(data, name: filename);
  String path = filename;
  if (!file.path.startsWith('/')) {
    if (UniversalPlatform.isDesktop) {
      path = '${(await getDownloadsDirectory())?.path}/$path';
    } else if (UniversalPlatform.isAndroid) {
      if (!await Permission.storage.request().isGranted) {
        return '';
      }
      path = '${await _channel.invokeMethod('getPicturesDirectory')}/$path';
    }
  }
  await file.saveTo(path);
  if (UniversalPlatform.isAndroid) {
    _channel.invokeMethod('scanFile', path.replaceAll('/$filename', ''));
  }
  return path;
}
