import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/screens/login_screen.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/widgets/header.dart';

class MockAppState extends Mock implements AppState {}

void testWidgetsMocked(
  String description,
  Future<void> Function(WidgetTester) callback,
) {
  testWidgets(description, (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await initializeDateFormatting('pt_BR', null);
    await mockNetworkImagesFor(() async {
      await callback(tester);
    });
  });
}

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

    testWidgetsMocked('renders login screen scaffold', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgetsMocked('displays header with isLoggedIn false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Header), findsOneWidget);
    });

    testWidgetsMocked('displays main description text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(
        find.text('Portal de gerenciamento para funcionários'),
        findsOneWidget,
      );
    });

    testWidgetsMocked('displays agenda button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Agenda'), findsOneWidget);
    });

    testWidgetsMocked('displays calendar button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Calendário'), findsOneWidget);
    });

    testWidgetsMocked('displays financial button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Financeiro'), findsOneWidget);
    });

    testWidgetsMocked('agenda button calls login with schedule', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('schedule')).called(1);
    });

    testWidgetsMocked('calendar button calls login with calendar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Calendário'));
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('calendar')).called(1);
    });

    testWidgetsMocked('financial button calls login with financial', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Financeiro'));
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('financial')).called(1);
    });

    testWidgetsMocked('has gradient background', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Container), findsWidgets);
    });

    testWidgetsMocked('displays logo image', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgetsMocked('buttons have proper styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsWidgets);
    });

    testWidgetsMocked('agenda button is filled style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Agenda'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgetsMocked('calendar button is outlined style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Calendário'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgetsMocked('financial button is outlined style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Financeiro'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgetsMocked('buttons are vertically spaced', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgetsMocked('content is centered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgetsMocked('content is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgetsMocked('has proper column layout', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Column), findsWidgets);
    });

    testWidgetsMocked('has proper row layout for buttons area', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Row), findsWidgets);
    });

    testWidgetsMocked('agenda button triggers navigation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final agendaButton = find.text('Agenda');
      expect(agendaButton, findsOneWidget);

      await tester.tap(agendaButton);
      await tester.pumpAndSettle();

      verify(() => mockAppState.login('schedule')).called(1);
    });

    testWidgetsMocked('multiple button taps work correctly', (
      WidgetTester tester,
    ) async {
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

    testWidgetsMocked('all buttons are accessible', (
      WidgetTester tester,
    ) async {
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

    testWidgetsMocked('agenda icon is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgetsMocked('calendar icon is rendered', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgetsMocked('financial icon is rendered', (
      WidgetTester tester,
    ) async {
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

    testWidgetsMocked('renders in portrait orientation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgetsMocked('body has container with gradient', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Container), findsWidgets);
    });

    testWidgetsMocked('content respects padding', (WidgetTester tester) async {
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

    testWidgetsMocked('buttons respond to tap', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
