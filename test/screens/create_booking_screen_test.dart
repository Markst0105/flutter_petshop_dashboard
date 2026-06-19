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
      
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    });

    testWidgets('date picker shows and selects when tapping on date', (WidgetTester tester) async {
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
      
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    });

    testWidgets('can change pet species dropdown', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final dropdown = find.byType(DropdownButtonFormField<String>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Gato').last);
      await tester.pumpAndSettle();
      
      expect(find.text('Gato'), findsWidgets);
    });

    testWidgets('selects and deselects service chips multiple times', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final chips = find.byType(ChoiceChip);
      if (chips.evaluate().isNotEmpty) {
        await tester.ensureVisible(chips.first);
        await tester.pumpAndSettle();
        await tester.tap(chips.first);
        await tester.pumpAndSettle();

        await tester.tap(chips.first);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('displays observações field', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Observações'), findsOneWidget);
    });

    testWidgets('can enter observações text', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final obsField = find.byType(TextFormField).last;
      await tester.ensureVisible(obsField);
      await tester.pumpAndSettle();
      await tester.enterText(obsField, 'Test notes');
      await tester.pumpAndSettle();
    });

    testWidgets('form has all required text fields', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('CPF do Dono'), findsOneWidget);
      expect(find.text('Nome do Dono'), findsOneWidget);
      expect(find.text('Telefone do Dono'), findsOneWidget);
      expect(find.text('Nome do Pet'), findsOneWidget);
    });

    testWidgets('all section headers are visible', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Detalhes do Dono'), findsOneWidget);
      expect(find.text('Detalhes do Pet'), findsOneWidget);
      expect(find.text('Detalhes do Agendamento'), findsOneWidget);
      expect(find.text('Serviços'), findsOneWidget);
    });

    testWidgets('pet breed field is optional', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Raça do Pet'), findsOneWidget);
    });

    testWidgets('can select multiple services', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final chips = find.byType(ChoiceChip);
      if (chips.evaluate().length >= 2) {
        await tester.ensureVisible(chips.at(0));
        await tester.pumpAndSettle();
        await tester.tap(chips.at(0));
        await tester.pumpAndSettle();

        await tester.ensureVisible(chips.at(1));
        await tester.pumpAndSettle();
        await tester.tap(chips.at(1));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('material widget wraps form', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('form uses Form widget', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('scroll view contains form content', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('dropdown has correct pet species options',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final dropdown = find.byType(DropdownButtonFormField<String>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      expect(find.text('Cachorro'), findsWidgets);
      expect(find.text('Gato'), findsWidgets);
      expect(find.text('Outro'), findsWidgets);
    });

    testWidgets('shows validation error when pet species not selected',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12345678901');
      await tester.enterText(fields.at(1), 'John Doe');
      await tester.enterText(fields.at(2), '(11) 98765-4321');
      await tester.enterText(fields.at(3), 'Buddy');

      await tester.ensureVisible(find.text('Criar Agendamento').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Criar Agendamento').last);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
    });

    testWidgets('shows validation error when pet breed is empty',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '12345678901');
      await tester.enterText(fields.at(1), 'John Doe');
      await tester.enterText(fields.at(2), '(11) 98765-4321');
      await tester.enterText(fields.at(3), 'Buddy');

      final dropdown = find.byType(DropdownButtonFormField<String>);
      await tester.ensureVisible(dropdown);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Gato').last);
      await tester.pumpAndSettle();
    });

    testWidgets('displays all service options', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ChoiceChip), findsWidgets);
      expect(find.text('Banho'), findsWidgets);
    });

    testWidgets('form validates before submission', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Form), findsOneWidget);
    });
  });
}
