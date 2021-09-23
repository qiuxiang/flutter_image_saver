import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_saver/flutter_image_saver.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final repaintBoundary = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepaintBoundary(
          key: repaintBoundary,
          child: const FlutterLogo(size: 120),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: save,
      ),
    );
  }

  void save() async {
    if (await Permission.storage.request().isGranted) {
      final boundary = repaintBoundary.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final path = await saveImage(
          data: byteData!.buffer.asUint8List(), filename: 'flutter.png');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved to $path')));
    }
  }
}
