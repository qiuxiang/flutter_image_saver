import 'package:flutter_image_saver_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app', (WidgetTester tester) async {
    await tester.pumpWidget(App());
  });
}
