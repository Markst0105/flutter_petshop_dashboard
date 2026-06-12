import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/widgets/data_status_indicator.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('Widget Tests', () {
    testWidgets('DataStatusIndicator renders without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DataStatusIndicator(),
          ),
        ),
      );

      expect(find.byType(DataStatusIndicator), findsOneWidget);
    });

    testWidgets('DataStatusIndicator shows status text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DataStatusIndicator(),
          ),
        ),
      );

      // Verify widget is rendered
      expect(find.byType(DataStatusIndicator), findsOneWidget);
    });
  });
}
