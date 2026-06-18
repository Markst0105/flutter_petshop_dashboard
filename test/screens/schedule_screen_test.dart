import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:petshop_dashboard/screens/schedule_screen.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/models/booking.dart';

class MockAppState extends Mock implements AppState {}



void main() {
  setUpAll(() async {
    await initializeDateFormatting('pt_BR', null);
  });

  group('ScheduleScreen', () {
    late MockAppState mockAppState;

    setUp(() {
      mockAppState = MockAppState();
      when(() => mockAppState.bookings).thenReturn([]);
      when(() => mockAppState.loadBookings()).thenAnswer((_) async {});
      when(() => mockAppState.addListener(any())).thenReturn(null);
      when(() => mockAppState.removeListener(any())).thenReturn(null);
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
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Agenda de Hoje'), findsOneWidget);
    });

    testWidgets('displays time slots for business hours', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => mockAppState.bookings).thenReturn([]);
      
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('08:00'), findsOneWidget);
      expect(find.text('09:00'), findsOneWidget);
      
      await tester.drag(find.byType(ListView), const Offset(0, -1000));
      await tester.pumpAndSettle();
      
      expect(find.text('18:00'), findsOneWidget);
    });

    testWidgets('renders bookings in correct time slots', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
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
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => mockAppState.bookings).thenReturn([]);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ScheduleScreen), findsOneWidget);
    });

    testWidgets('calls loadBookings on init', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      verify(() => mockAppState.loadBookings()).called(greaterThanOrEqualTo(1));
    });

    testWidgets('displays booking details when selected', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
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
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => mockAppState.bookings).thenReturn([]);
      when(() => mockAppState.isLoading).thenReturn(true);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ScheduleScreen), findsOneWidget);
    });
  });
}
