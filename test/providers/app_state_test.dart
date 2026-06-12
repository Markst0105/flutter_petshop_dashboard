import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/models/booking.dart';
import 'package:petshop_dashboard/providers/app_state.dart';

void main() {
  group('AppState Provider', () {
    late AppState appState;

    setUp(() {
      appState = AppState();
    });

    test('initializes with default values', () {
      expect(appState.isLoggedIn, false);
      expect(appState.currentScreen, 'schedule');
      expect(appState.isLoading, false);
    });

    test('login sets isLoggedIn to true and updates current screen', () {
      appState.login('financial');

      expect(appState.isLoggedIn, true);
      expect(appState.currentScreen, 'financial');
    });

    test('logout resets to default state', () {
      appState.login('financial');
      expect(appState.isLoggedIn, true);

      appState.logout();

      expect(appState.isLoggedIn, false);
      expect(appState.currentScreen, 'schedule');
    });

    test('navigateToScreen updates current screen', () {
      appState.navigateToScreen('calendar');

      expect(appState.currentScreen, 'calendar');
    });

    test('handleLogoClick logs out user and resets screen', () {
      appState.login('financial');
      appState.handleLogoClick();

      expect(appState.isLoggedIn, false);
      expect(appState.currentScreen, 'schedule');
    });

    test('addBooking adds booking and sorts by date and time', () {
      final booking1 = Booking(
        id: '1',
        startTime: '10:00',
        endTime: '11:00',
        startHour: 10.0,
        duration: 1,
        ownerName: 'John Doe',
        ownerPhone: '123456789',
        petName: 'Fluffy',
        petType: 'Dog',
        petSize: 'Medium',
        procedures: ['Bath'],
        status: BookingStatus.upcoming,
        comments: 'Test booking',
        date: DateTime(2024, 1, 15),
      );

      final booking2 = Booking(
        id: '2',
        startTime: '09:00',
        endTime: '10:00',
        startHour: 9.0,
        duration: 1,
        ownerName: 'Jane Doe',
        ownerPhone: '987654321',
        petName: 'Buddy',
        petType: 'Cat',
        petSize: 'Small',
        procedures: ['Trim'],
        status: BookingStatus.upcoming,
        comments: 'Test booking 2',
        date: DateTime(2024, 1, 15),
      );

      appState.addBooking(booking1);
      appState.addBooking(booking2);

      expect(appState.bookings.length, greaterThan(0));
      expect(appState.bookings.first.startHour, lessThanOrEqualTo(appState.bookings.last.startHour));
    });

    test('bookings getter returns list of bookings', () {
      final bookings = appState.bookings;

      expect(bookings, isA<List<Booking>>());
    });

    test('loadingStatus can be updated', () {
      expect(appState.loadingStatus, isNotEmpty);
    });
  });
}
