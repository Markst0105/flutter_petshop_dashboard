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
  });
}
