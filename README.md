# flutter_image_saver

[![pub package](https://img.shields.io/pub/v/flutter_image_saver.svg)](https://pub.dartlang.org/packages/flutter_image_saver)

`XFile` 已经提供了可用的跨平台文件接口，包括 `fromData(data)`、`saveTo(path)`，在不需要权限的 web 和桌面端， 无需任何适配，仅使用 XFile
已经可以很简单的实现图片数据另存为文件（默认保存到下载目录）。

对于 android，在权限允许的情况下也可以直接使用 XFile 的 saveTo 方法进行文件写入，只需要处理好以下问题：

1. 外部存储写入权限申请，包括 `manifest` 里的权限声明和运行时权限申请。

2. 通过原生接口获取外部存储 `Pictures` 目录路径，将文件写入该目录，需要注意的是从 android 11 开始，`WRITE_EXTERNAL_STORAGE`
   就只能写入媒体目录，如 `Pictures`、`DCIM` 等，写入其他目录会被拒绝。android 10 很特殊，必须声明
   `<application android:requestLegacyExternalStorage="true">` 才能正常写入。

3. 调用原生接口通知 android 系统更新图片索引。

_虽然使用 Media 接口是更好的做法，但目前继续使用 io 接口写入文件也不是什么问题，只要符合规范_

对于 ios，只能调用原生接口进行写入，目前暂未实现。
