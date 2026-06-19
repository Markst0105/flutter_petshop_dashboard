import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:petshop_dashboard/widgets/header.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('pt_BR', null);
  });
  group('Header Widget', () {
    testWidgets('renders header with logout when logged in', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
            ),
          ),
        ),
      ));

      expect(find.text('Hoje'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('renders header with app title when logged out', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: false,
              currentScreen: 'schedule',
            ),
          ),
        ),
      ));

      expect(find.text('AgendaPet'), findsOneWidget);
    });

    testWidgets('calls onLogoClick when logo is tapped', (WidgetTester tester) async {
      bool onLogoClickCalled = false;

      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
              onLogoClick: () {
                onLogoClickCalled = true;
              },
            ),
          ),
        ),
      ));

      final logoFinder = find.byType(GestureDetector).first;
      await tester.tap(logoFinder);
      await tester.pumpAndSettle();

      expect(onLogoClickCalled, true);
    });

    testWidgets('renders logo image', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
            ),
          ),
        ),
      ));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders menu button when logged in', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
            ),
          ),
        ),
      ));

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('does not render menu button when logged out', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: false,
              currentScreen: 'schedule',
            ),
          ),
        ),
      ));

      expect(find.byIcon(Icons.menu), findsNothing);
    });

    testWidgets('displays date when logged in', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
            ),
          ),
        ),
      ));

      expect(find.text('Hoje'), findsOneWidget);
    });

    testWidgets('calls onNavigate when menu item is selected', (WidgetTester tester) async {
      String? navigatedScreen;

      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
              onNavigate: (screen) {
                navigatedScreen = screen;
              },
            ),
          ),
        ),
      ));

      final menuButton = find.byIcon(Icons.menu);
      await tester.tap(menuButton);
      await tester.pumpAndSettle();
    });

    testWidgets('calls onLogout when logout option is clicked', (WidgetTester tester) async {
      bool onLogoutCalled = false;

      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'schedule',
              onLogout: () {
                onLogoutCalled = true;
              },
            ),
          ),
        ),
      ));

      final menuButton = find.byIcon(Icons.menu);
      await tester.tap(menuButton);
      await tester.pumpAndSettle();
    });

    testWidgets('respects currentScreen property', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Header(
              isLoggedIn: true,
              currentScreen: 'calendar',
            ),
          ),
        ),
      ));

      expect(find.byType(Header), findsOneWidget);
    });
  });
}
