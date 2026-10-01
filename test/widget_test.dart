import 'package:flutter_test/flutter_test.dart';
import 'package:simple_intrest/main.dart';

void main() {
  testWidgets('Simple Interest Calculator App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SimpleInterestApp());

    // Verify that the title and tabs are rendered.
    expect(find.text('Simple Interest Calculator'), findsOneWidget);
    expect(find.text('Simple Interest'), findsOneWidget);
    expect(find.text('Basic Operations'), findsOneWidget);
  });
}
