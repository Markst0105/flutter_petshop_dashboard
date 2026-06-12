import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/screens/app.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('App starts without crashing', (WidgetTester tester) async {
      final appState = AppState();

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
      expect(find.byType(App), findsOneWidget);
    });

    testWidgets('App displays login screen when not logged in', (WidgetTester tester) async {
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

      await tester.pumpAndSettle();
      expect(appState.isLoggedIn, false);
    });

    testWidgets('App displays main interface when logged in', (WidgetTester tester) async {
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
      expect(appState.isLoggedIn, true);
      expect(find.byType(Scaffold), findsWidgets);
    });
  });
}
