# flutter_image_saver

[![pub package](https://img.shields.io/pub/v/flutter_image_saver.svg)](https://pub.dartlang.org/packages/flutter_image_saver)

Simple and effective cross platform image saver plugin for flutter.

## Usage

```dart
await saveImage(data: uint8ListData, filename: 'image.png');
```

### Android

`android/app/src/main/AndroidManifest.xml` add property
`android:requestLegacyExternalStorage="true"` to `<application>`.
