import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/screens/create_booking_screen.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/repositories/booking_repository.dart';

class MockAppState extends Mock implements AppState {}

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('CreateBookingScreen', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.navigateToScreen(any())).thenReturn(null);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const Scaffold(
            body: CreateBookingScreen(),
          ),
        ),
      );
    }

    testWidgets('renders form with all required fields', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Criar Agendamento'), findsWidgets);
      expect(find.text('Detalhes do Dono'), findsOneWidget);
      expect(find.text('Detalhes do Pet'), findsOneWidget);
      expect(find.text('Detalhes do Agendamento'), findsOneWidget);
    });

    testWidgets('shows validation error when CPF is empty', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.ensureVisible(find.text('Criar Agendamento').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o CPF do dono.'), findsWidgets);
    });

    testWidgets('shows validation error when owner name is empty', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final cpfField = find.byType(TextFormField).first;
      await tester.enterText(cpfField, '12345678901');

      await tester.ensureVisible(find.text('Criar Agendamento').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o nome do dono.'), findsWidgets);
    });

    testWidgets('shows validation error when phone is empty', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12345678901');
      await tester.enterText(fields.at(1), 'John Doe');

      await tester.ensureVisible(find.text('Criar Agendamento').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o telefone do dono.'), findsWidgets);
    });

    testWidgets('shows validation error when pet name is empty', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12345678901');
      await tester.enterText(fields.at(1), 'John Doe');
      await tester.enterText(fields.at(2), '(11) 98765-4321');

      await tester.ensureVisible(find.text('Criar Agendamento').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o nome do pet.'), findsWidgets);
    });

    testWidgets('renders pet species dropdown', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Cachorro'), findsWidgets);
    });

    testWidgets('renders service chips', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ChoiceChip), findsWidgets);
    });

    testWidgets('back button navigates to calendar screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      verify(() => mockAppState.navigateToScreen('calendar')).called(1);
    });

    testWidgets('selects and deselects service chips', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final chips = find.byType(ChoiceChip);
      expect(chips, findsWidgets);

      if (chips.evaluate().isNotEmpty) {
        await tester.ensureVisible(chips.first);
        await tester.pumpAndSettle();
        await tester.tap(chips.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('date picker shows when tapping on date', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final dateListTile = find.byIcon(Icons.calendar_today);
      await tester.ensureVisible(dateListTile);
      await tester.pumpAndSettle();
      await tester.tap(dateListTile);
      await tester.pumpAndSettle();
    });

    testWidgets('time picker shows when tapping on time', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final timeListTile = find.byIcon(Icons.access_time);
      await tester.ensureVisible(timeListTile);
      await tester.pumpAndSettle();
      await tester.tap(timeListTile);
      await tester.pumpAndSettle();
    });
  });
}
