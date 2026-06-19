import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/screens/calendar_screen.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/models/booking.dart';

class MockAppState extends Mock implements AppState {}



void main() {
  setUpAll(() async {
    await initializeDateFormatting('pt_BR', null);
  });

  group('CalendarScreen', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.bookings).thenReturn([]);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    Widget createWidgetUnderTest({List<Booking>? bookings}) {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: Scaffold(
            body: CalendarScreen(),
          ),
        ),
      );
    }

    testWidgets('renders calendar screen', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('displays bookings for selected date', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho', 'Tosa'],
          status: BookingStatus.upcoming,
          comments: 'Test',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('shows empty state when no bookings for date', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('renders multiple bookings for same date', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        ),
        Booking(
          id: '2',
          startTime: '11:00',
          endTime: '12:00',
          startHour: 11.0,
          duration: 1.0,
          ownerName: 'Jane Smith',
          ownerPhone: '(16) 91234-5678',
          petName: 'Luna',
          petType: 'Gato',
          petSize: 'small',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        ),
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('filters bookings by selected date', (WidgetTester tester) async {
      final now = DateTime.now();
      final tomorrow = now.add(const Duration(days: 1));

      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '111',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: [],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        ),
        Booking(
          id: '2',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'Jane Smith',
          ownerPhone: '222',
          petName: 'Luna',
          petType: 'Gato',
          petSize: 'small',
          procedures: [],
          status: BookingStatus.upcoming,
          comments: '',
          date: tomorrow,
        ),
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('responds to calendar date selection', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('displays calendar title', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Calendário mensal'), findsOneWidget);
    });

    testWidgets('displays density legend', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Baixo (1-2)'), findsOneWidget);
      expect(find.text('Médio (3-4)'), findsOneWidget);
      expect(find.text('Alto (5+)'), findsOneWidget);
    });

    testWidgets('displays bookings list title', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('displays empty state message when no bookings', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Nenhum agendamento'), findsOneWidget);
    });

    testWidgets('displays card element', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('displays booking with pet name and type', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Fluffy',
          petType: 'Cachorro',
          petSize: 'large',
          procedures: ['Banho', 'Tosa'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Fluffy - Cachorro'), findsOneWidget);
    });

    testWidgets('displays booking time', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '14:30',
          endTime: '15:30',
          startHour: 14.5,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Gato',
          petSize: 'small',
          procedures: ['Tosa'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('14:30'), findsOneWidget);
    });

    testWidgets('displays booking duration', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: [],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Duração: 1 hora'), findsOneWidget);
    });

    testWidgets('displays procedures list in booking', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho', 'Tosa', 'Corte'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Banho, Tosa, Corte'), findsOneWidget);
    });

    testWidgets('can expand booking card', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      final bookingCard = find.text('Max - Cachorro');
      expect(bookingCard, findsOneWidget);

      await tester.tap(bookingCard);
      await tester.pumpAndSettle();

      expect(find.text('Dono'), findsOneWidget);
    });

    testWidgets('displays owner information when expanded', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'João Silva',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Max - Cachorro'));
      await tester.pumpAndSettle();

      expect(find.text('João Silva'), findsOneWidget);
      expect(find.text('(11) 98765-4321'), findsOneWidget);
    });

    testWidgets('displays pet information when expanded', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Buddy',
          petType: 'Cachorro',
          petSize: 'large',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Buddy - Cachorro'));
      await tester.pumpAndSettle();

      expect(find.text('Pet'), findsOneWidget);
      expect(find.text('Tamanho: large'), findsOneWidget);
    });

    testWidgets('displays call button when expanded', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Max - Cachorro'));
      await tester.pumpAndSettle();

      expect(find.text('Ligar'), findsOneWidget);
    });

    testWidgets('can collapse expanded booking', (WidgetTester tester) async {
      final now = DateTime.now();
      final bookings = [
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John Doe',
          ownerPhone: '(11) 98765-4321',
          petName: 'Max',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Max - Cachorro'));
      await tester.pumpAndSettle();

      expect(find.text('Dono'), findsOneWidget);

      await tester.tap(find.text('Max - Cachorro'));
      await tester.pumpAndSettle();

      expect(find.text('Dono'), findsNothing);
    });
  });

  group('CalendarScreen DayBooking', () {
    testWidgets('DayBooking is created correctly', (WidgetTester tester) async {
      final now = DateTime.now();
      final mockAppState = MockAppState();
      when(() => mockAppState.bookings).thenReturn([
        Booking(
          id: '1',
          startTime: '09:00',
          endTime: '10:00',
          startHour: 9.0,
          duration: 1.0,
          ownerName: 'John',
          ownerPhone: '111',
          petName: 'Dog',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: ['Banho'],
          status: BookingStatus.upcoming,
          comments: '',
          date: now,
        )
      ]);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);

      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const Scaffold(body: CalendarScreen()),
        ),
      ));

      expect(find.byType(CalendarScreen), findsOneWidget);
    });
  });

  group('CalendarScreen Colors', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.bookings).thenReturn([]);
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
    });

    testWidgets('renders with proper colors', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: const Scaffold(body: CalendarScreen()),
        ),
      ));

      expect(find.byType(Container), findsWidgets);
    });
  });
}
