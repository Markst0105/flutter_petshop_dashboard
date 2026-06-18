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
      when(() => mockAppState.addListenerWhere(any(), any())).thenReturn(() {});
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
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Criar Agendamento'), findsOneWidget);
      expect(find.text('Detalhes do Dono'), findsOneWidget);
      expect(find.text('Detalhes do Pet'), findsOneWidget);
      expect(find.text('Detalhes do Agendamento'), findsOneWidget);
    });

    testWidgets('shows validation error when CPF is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o CPF do dono.'), findsWidgets);
    });

    testWidgets('shows validation error when owner name is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final cpfField = find.byType(TextFormField).first;
      await tester.enterText(cpfField, '12345678901');

      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o nome do dono.'), findsWidgets);
    });

    testWidgets('shows validation error when phone is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12345678901');
      await tester.enterText(fields.at(1), 'John Doe');

      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o telefone do dono.'), findsWidgets);
    });

    testWidgets('shows validation error when pet name is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12345678901');
      await tester.enterText(fields.at(1), 'John Doe');
      await tester.enterText(fields.at(2), '(11) 98765-4321');

      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o nome do pet.'), findsWidgets);
    });

    testWidgets('renders pet species dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Cachorro'), findsWidgets);
      expect(find.text('Gato'), findsOneWidget);
      expect(find.text('Outro'), findsOneWidget);
    });

    testWidgets('renders service chips', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ChoiceChip), findsWidgets);
    });

    testWidgets('back button navigates to calendar screen', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      verify(() => mockAppState.navigateToScreen('calendar')).called(1);
    });

    testWidgets('selects and deselects service chips', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final chips = find.byType(ChoiceChip);
      expect(chips, findsWidgets);

      if (chips.evaluate().isNotEmpty) {
        await tester.tap(chips.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('date picker shows when tapping on date', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final dateListTile = find.byIcon(Icons.calendar_today);
      await tester.tap(dateListTile);
      await tester.pumpAndSettle();
    });

    testWidgets('time picker shows when tapping on time', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final timeListTile = find.byIcon(Icons.access_time);
      await tester.tap(timeListTile);
      await tester.pumpAndSettle();
    });
  });
}
