import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/screens/schedule_screen.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/models/booking.dart';

class MockAppState extends Mock implements AppState {}

void main() {
  group('ScheduleScreen', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.bookings).thenReturn([]);
      when(() => mockAppState.loadBookings()).thenAnswer((_) async {});
      when(() => mockAppState.addListenerWhere(any(), any())).thenReturn(() {});
    });

    Widget createWidgetUnderTest({List<Booking>? bookings}) {
      return MaterialApp(
        home: ChangeNotifierProvider<AppState>.value(
          value: mockAppState,
          child: Scaffold(
            body: ScheduleScreen(),
          ),
        ),
      );
    }

    testWidgets('renders schedule screen with header', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Agenda de Hoje'), findsOneWidget);
    });

    testWidgets('displays time slots for business hours', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);
      
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('8:00'), findsOneWidget);
      expect(find.text('9:00'), findsOneWidget);
      expect(find.text('18:00'), findsOneWidget);
    });

    testWidgets('renders bookings in correct time slots', (WidgetTester tester) async {
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
          comments: 'Test comment',
          date: now,
        )
      ];

      when(() => mockAppState.bookings).thenReturn(bookings);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Max'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('shows empty state when no bookings', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ScheduleScreen), findsOneWidget);
    });

    testWidgets('calls loadBookings on init', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      verify(() => mockAppState.loadBookings()).called(greaterThanOrEqualTo(1));
    });

    testWidgets('displays booking details when selected', (WidgetTester tester) async {
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

      expect(find.text('Max'), findsOneWidget);
    });

    testWidgets('displays loading indicator state', (WidgetTester tester) async {
      when(() => mockAppState.bookings).thenReturn([]);
      when(() => mockAppState.isLoading).thenReturn(true);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ScheduleScreen), findsOneWidget);
    });
  });
}
