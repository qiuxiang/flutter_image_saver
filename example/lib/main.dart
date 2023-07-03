import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_saver/flutter_image_saver.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
      body: RepaintBoundary(
        key: repaintBoundary,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              alignment: Alignment.topRight,
              image: AssetImage('images/demo.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
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
    final boundary = repaintBoundary.currentContext!.findRenderObject()!
        as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final path = await saveImage(byteData!.buffer.asUint8List(), 'flutter.png');
    final message = path.isEmpty ? 'Saved' : 'Saved to $path';
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
