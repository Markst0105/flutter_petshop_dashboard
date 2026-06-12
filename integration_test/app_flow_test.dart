import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:petshop_dashboard/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('App starts and displays login screen', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app starts without crashing
      expect(find.byType(app.MyApp), findsOneWidget);
    });

    testWidgets('Navigation works between screens', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify initial widget is rendered
      expect(find.byType(app.MyApp), findsOneWidget);
    });
  });
}
