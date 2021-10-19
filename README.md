# flutter_image_saver

[![pub package](https://img.shields.io/pub/v/flutter_image_saver.svg)](https://pub.dartlang.org/packages/flutter_image_saver)

Simple and effective cross platform image saver for flutter, supported web and desktop.

## Usage

```dart
final savedPath = await saveImage(data, 'image.png');
```

### Android

`android/app/src/main/AndroidManifest.xml`:

Add `android:requestLegacyExternalStorage="true"` to `<application>`.

### iOS

Add `NSPhotoLibraryAddUsageDescription` to `Info.plist`
