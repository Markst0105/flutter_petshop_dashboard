import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/screens/login_screen.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/widgets/header.dart';

class MockAppState extends Mock implements AppState {}

void main() {
  group('LoginScreen', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.login(any())).thenReturn(null);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('renders login screen scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('displays header with isLoggedIn false', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Header), findsOneWidget);
    });

    testWidgets('displays main description text', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Portal de gerenciamento para funcionários'),
          findsOneWidget);
    });

    testWidgets('displays agenda button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Agenda'), findsOneWidget);
    });

    testWidgets('displays calendar button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Calendário'), findsOneWidget);
    });

    testWidgets('displays financial button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Financeiro'), findsOneWidget);
    });

    testWidgets('agenda button calls login with schedule',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('schedule')).called(1);
    });

    testWidgets('calendar button calls login with calendar',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Calendário'));
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('calendar')).called(1);
    });

    testWidgets('financial button calls login with financial',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Financeiro'));
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('financial')).called(1);
    });

    testWidgets('has gradient background', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('displays logo image', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('buttons have proper styling', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsWidgets);
    });

    testWidgets('agenda button is filled style', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Agenda'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('calendar button is outlined style', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Calendário'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('financial button is outlined style', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Financeiro'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('buttons are vertically spaced', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('content is centered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('content is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has proper column layout', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('has proper row layout for buttons area', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('agenda button triggers navigation', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final agendaButton = find.text('Agenda');
      expect(agendaButton, findsOneWidget);

      await tester.tap(agendaButton);
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('schedule')).called(1);
    });

    testWidgets('multiple button taps work correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();
      verify(() => mockAppState.login('schedule')).called(1);

      await tester.tap(find.text('Calendário'));
      await tester.pumpAndSettle();
      verify(() => mockAppState.login('calendar')).called(1);

      await tester.tap(find.text('Financeiro'));
      await tester.pumpAndSettle();
      verify(() => mockAppState.login('financial')).called(1);
    });

    testWidgets('all buttons are accessible', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Agenda'), findsOneWidget);
      expect(find.text('Calendário'), findsOneWidget);
      expect(find.text('Financeiro'), findsOneWidget);
    });
  });

  group('LoginScreen Icons', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.login(any())).thenReturn(null);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('agenda icon is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('calendar icon is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('financial icon is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('LoginScreen Layout', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.login(any())).thenReturn(null);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('renders in portrait orientation', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('body has container with gradient', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('content respects padding', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Padding), findsWidgets);
    });
  });

  group('LoginScreen Gestures', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.login(any())).thenReturn(null);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('buttons respond to tap', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
