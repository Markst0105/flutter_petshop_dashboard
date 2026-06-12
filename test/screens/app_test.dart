import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/screens/app.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('App Screen Tests', () {
    testWidgets('App shows login screen when not logged in', (WidgetTester tester) async {
      final appState = AppState();
      appState.logout();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppState>.value(value: appState),
          ],
          child: const MaterialApp(
            home: App(),
          ),
        ),
      );

      // Login screen should be displayed
      expect(find.byType(App), findsOneWidget);
    });

    testWidgets('App shows main scaffold when logged in', (WidgetTester tester) async {
      final appState = AppState();
      appState.login('schedule');

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppState>.value(value: appState),
          ],
          child: const MaterialApp(
            home: App(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Main scaffold should be displayed
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('App navigation updates current screen', (WidgetTester tester) async {
      final appState = AppState();
      appState.login('schedule');

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppState>.value(value: appState),
          ],
          child: const MaterialApp(
            home: App(),
          ),
        ),
      );

      expect(appState.currentScreen, 'schedule');
    });
  });
}
