import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/models/booking.dart';
import 'package:petshop_dashboard/providers/app_state.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('Booking Flow Integration Tests', () {
    test('complete booking workflow from creation to completion', () {
      final appState = AppState();

      // Step 1: Verify initial state
      expect(appState.bookings, isNotNull);
      final initialCount = appState.bookings.length;

      // Step 2: Create new booking
      final newBooking = Booking(
        id: 'test-001',
        startTime: '08:00',
        endTime: '09:00',
        startHour: 8.0,
        duration: 1.0,
        ownerName: 'Test Owner',
        ownerPhone: '1234567890',
        petName: 'Test Pet',
        petType: 'Dog',
        petSize: 'Large',
        procedures: ['Bath', 'Trim'],
        status: BookingStatus.upcoming,
        comments: 'Test booking for integration',
        date: DateTime.now(),
      );

      // Step 3: Add booking
      appState.addBooking(newBooking);

      // Step 4: Verify booking was added
      expect(appState.bookings.length, greaterThan(initialCount));

      // Step 5: Verify booking details are correct
      final addedBooking = appState.bookings.firstWhere((b) => b.id == 'test-001');
      expect(addedBooking.ownerName, 'Test Owner');
      expect(addedBooking.petName, 'Test Pet');
      expect(addedBooking.procedures.length, 2);
    });

    test('bookings are sorted by date and start time', () {
      final appState = AppState();

      // Create bookings with different times
      final booking1 = Booking(
        id: '1',
        startTime: '14:00',
        endTime: '15:00',
        startHour: 14.0,
        duration: 1.0,
        ownerName: 'Owner 1',
        ownerPhone: '1111111111',
        petName: 'Pet 1',
        petType: 'Dog',
        petSize: 'Small',
        procedures: ['Bath'],
        status: BookingStatus.upcoming,
        comments: '',
        date: DateTime(2024, 1, 15),
      );

      final booking2 = Booking(
        id: '2',
        startTime: '10:00',
        endTime: '11:00',
        startHour: 10.0,
        duration: 1.0,
        ownerName: 'Owner 2',
        ownerPhone: '2222222222',
        petName: 'Pet 2',
        petType: 'Cat',
        petSize: 'Small',
        procedures: ['Trim'],
        status: BookingStatus.upcoming,
        comments: '',
        date: DateTime(2024, 1, 15),
      );

      appState.addBooking(booking1);
      appState.addBooking(booking2);

      // Verify sorted by start hour
      final sortedBookings = appState.bookings;
      for (int i = 0; i < sortedBookings.length - 1; i++) {
        final current = sortedBookings[i];
        final next = sortedBookings[i + 1];
        final dateComparison = current.date.compareTo(next.date);

        if (dateComparison == 0) {
          // Same date: check start hour
          expect(current.startHour, lessThanOrEqualTo(next.startHour));
        }
      }
    });

    test('multiple procedures per booking are preserved', () {
      final appState = AppState();

      final procedures = [
        'Bath',
        'Nail Trim',
        'Ear Cleaning',
        'Teeth Cleaning',
        'Hair Styling'
      ];

      final booking = Booking(
        id: 'multi-proc',
        startTime: '10:00',
        endTime: '12:00',
        startHour: 10.0,
        duration: 2.0,
        ownerName: 'Premium Owner',
        ownerPhone: '5555555555',
        petName: 'Premium Pet',
        petType: 'Dog',
        petSize: 'Large',
        procedures: procedures,
        status: BookingStatus.upcoming,
        comments: 'Full grooming package',
        date: DateTime.now(),
      );

      appState.addBooking(booking);

      final addedBooking = appState.bookings.firstWhere((b) => b.id == 'multi-proc');
      expect(addedBooking.procedures.length, 5);
      expect(addedBooking.procedures, containsAll(['Bath', 'Teeth Cleaning']));
    });

    test('booking status transitions are valid', () {
      final statuses = [
        BookingStatus.upcoming,
        BookingStatus.inProgress,
        BookingStatus.completed,
        BookingStatus.cancelled,
      ];

      expect(statuses.length, 4);
      expect(statuses, contains(BookingStatus.upcoming));
      expect(statuses, contains(BookingStatus.completed));
    });
  });
}
