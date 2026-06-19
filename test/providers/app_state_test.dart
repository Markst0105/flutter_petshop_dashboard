import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petshop_dashboard/models/booking.dart';
import 'package:petshop_dashboard/providers/app_state.dart';
import 'package:petshop_dashboard/repositories/booking_repository.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('AppState', () {
    late MockBookingRepository mockRepository;
    late AppState appState;

    setUp(() {
      mockRepository = MockBookingRepository();
    });

    group('initialization', () {
      test('initializes with correct default values', () {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);

        expect(appState.isLoggedIn, false);
        expect(appState.currentScreen, 'schedule');
        expect(appState.bookings, isEmpty);
        expect(appState.isLoading, false);
      });
    });

    group('loadBookings', () {
      test('loads bookings successfully', () async {
        final mockBookings = [
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
            date: DateTime.now(),
          )
        ];

        when(() => mockRepository.getBookings()).thenAnswer((_) async => mockBookings);

        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));

        expect(appState.isLoading, false);
        expect(appState.bookings.length, 1);
        expect(appState.bookings.first.ownerName, 'John Doe');
      });

      test('uses fallback data when no bookings are returned', () async {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));

        expect(appState.bookings, isNotEmpty);
        expect(appState.loadingStatus, 'Bookings loaded successfully');
      });

      test('sets error status on exception', () async {
        when(() => mockRepository.getBookings()).thenThrow(Exception('Network error'));

        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));

        expect(appState.isLoading, false);
        expect(appState.lastError, isNotNull);
        expect(appState.bookings, isNotEmpty); // Uses fallback data
      });

      test('sets specific error status on Failed host lookup', () async {
        when(() => mockRepository.getBookings()).thenThrow(Exception('Failed host lookup'));
        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));
        expect(appState.loadingStatus, contains('Network Error'));
      });
      
      test('sets access error status on CORS', () async {
        when(() => mockRepository.getBookings()).thenThrow(Exception('CORS'));
        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));
        expect(appState.loadingStatus, contains('Access Error'));
      });

      test('sets connection error status on Connection refused', () async {
        when(() => mockRepository.getBookings()).thenThrow(Exception('Connection refused'));
        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));
        expect(appState.loadingStatus, contains('Connection Error'));
      });

      test('sorts bookings by date and time', () async {
        final today = DateTime.now();
        final tomorrow = today.add(const Duration(days: 1));

        final mockBookings = [
          Booking(
            id: '1',
            startTime: '10:00',
            endTime: '11:00',
            startHour: 10.0,
            duration: 1.0,
            ownerName: 'John',
            ownerPhone: '111',
            petName: 'Max',
            petType: 'Cachorro',
            petSize: 'medium',
            procedures: [],
            status: BookingStatus.upcoming,
            comments: '',
            date: tomorrow,
          ),
          Booking(
            id: '2',
            startTime: '09:00',
            endTime: '10:00',
            startHour: 9.0,
            duration: 1.0,
            ownerName: 'Jane',
            ownerPhone: '222',
            petName: 'Luna',
            petType: 'Gato',
            petSize: 'small',
            procedures: [],
            status: BookingStatus.upcoming,
            comments: '',
            date: today,
          )
        ];

        when(() => mockRepository.getBookings()).thenAnswer((_) async => mockBookings);

        appState = AppState(repository: mockRepository);
        await Future.delayed(const Duration(milliseconds: 600));

        expect(appState.bookings[0].date, today);
        expect(appState.bookings[1].date, tomorrow);
      });
    });

    group('login', () {
      test('sets isLoggedIn to true and updates current screen', () {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);
        appState.login('calendar');

        expect(appState.isLoggedIn, true);
        expect(appState.currentScreen, 'calendar');
      });
    });

    group('logout', () {
      test('sets isLoggedIn to false and returns to schedule screen', () {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);
        appState.login('calendar');
        appState.logout();

        expect(appState.isLoggedIn, false);
        expect(appState.currentScreen, 'schedule');
      });
    });

    group('navigateToScreen', () {
      test('updates current screen', () {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);
        appState.navigateToScreen('financial');

        expect(appState.currentScreen, 'financial');
      });
    });

    group('handleLogoClick', () {
      test('logs out user and resets to schedule screen', () {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);
        appState.login('calendar');
        appState.handleLogoClick();

        expect(appState.isLoggedIn, false);
        expect(appState.currentScreen, 'schedule');
      });
    });

    group('addBooking', () {
      test('adds booking and sorts by date and time', () {
        when(() => mockRepository.getBookings()).thenAnswer((_) async => []);

        appState = AppState(repository: mockRepository);
        
        final today = DateTime.now();
        final newBooking = Booking(
          id: '99',
          startTime: '15:00',
          endTime: '16:00',
          startHour: 15.0,
          duration: 1.0,
          ownerName: 'Test',
          ownerPhone: '999',
          petName: 'TestPet',
          petType: 'Cachorro',
          petSize: 'medium',
          procedures: [],
          status: BookingStatus.upcoming,
          comments: '',
          date: today,
        );

        final initialCount = appState.bookings.length;
        appState.addBooking(newBooking);

        expect(appState.bookings.length, initialCount + 1);
        expect(appState.bookings.last.id, '99');
      });
    });
  });
}
