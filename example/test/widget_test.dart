import 'package:flutter_test/flutter_test.dart';
import 'package:tappable_example/main.dart';

void main() {
  testWidgets('Tappable example app smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const TappableExampleApp());

    // Verify the app loads successfully.
    expect(find.text('Tappable Examples'), findsOneWidget);
  });
}
