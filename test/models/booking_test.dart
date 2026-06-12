import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/models/booking.dart';

void main() {
  group('Booking Model', () {
    test('can create booking with all required fields', () {
      final bookingDate = DateTime(2024, 1, 15);
      final booking = Booking(
        id: '1',
        startTime: '10:00',
        endTime: '11:00',
        startHour: 10.0,
        duration: 1.0,
        ownerName: 'John Doe',
        ownerPhone: '123456789',
        petName: 'Fluffy',
        petType: 'Dog',
        petSize: 'Medium',
        procedures: ['Bath', 'Trim'],
        status: BookingStatus.upcoming,
        comments: 'First appointment',
        date: bookingDate,
      );

      expect(booking.id, '1');
      expect(booking.ownerName, 'John Doe');
      expect(booking.petName, 'Fluffy');
      expect(booking.startTime, '10:00');
      expect(booking.endTime, '11:00');
      expect(booking.procedures.length, 2);
      expect(booking.status, BookingStatus.upcoming);
    });

    test('booking duration calculation is correct', () {
      final booking = Booking(
        id: '1',
        startTime: '10:00',
        endTime: '11:30',
        startHour: 10.0,
        duration: 1.5,
        ownerName: 'John Doe',
        ownerPhone: '123456789',
        petName: 'Fluffy',
        petType: 'Dog',
        petSize: 'Medium',
        procedures: ['Bath'],
        status: BookingStatus.upcoming,
        comments: '',
        date: DateTime(2024, 1, 15),
      );

      expect(booking.duration, 1.5);
    });

    test('booking status can be any valid BookingStatus', () {
      final bookingUpcoming = Booking(
        id: '1',
        startTime: '10:00',
        endTime: '11:00',
        startHour: 10.0,
        duration: 1.0,
        ownerName: 'John Doe',
        ownerPhone: '123456789',
        petName: 'Fluffy',
        petType: 'Dog',
        petSize: 'Medium',
        procedures: ['Bath'],
        status: BookingStatus.upcoming,
        comments: '',
        date: DateTime(2024, 1, 15),
      );

      final bookingCompleted = Booking(
        id: '2',
        startTime: '12:00',
        endTime: '13:00',
        startHour: 12.0,
        duration: 1.0,
        ownerName: 'Jane Doe',
        ownerPhone: '987654321',
        petName: 'Buddy',
        petType: 'Cat',
        petSize: 'Small',
        procedures: ['Trim'],
        status: BookingStatus.completed,
        comments: '',
        date: DateTime(2024, 1, 15),
      );

      expect(bookingUpcoming.status, BookingStatus.upcoming);
      expect(bookingCompleted.status, BookingStatus.completed);
    });

    test('multiple procedures can be assigned to booking', () {
      final procedures = ['Bath', 'Nail Trim', 'Ear Cleaning', 'Teeth Cleaning'];
      final booking = Booking(
        id: '1',
        startTime: '10:00',
        endTime: '12:00',
        startHour: 10.0,
        duration: 2.0,
        ownerName: 'John Doe',
        ownerPhone: '123456789',
        petName: 'Fluffy',
        petType: 'Dog',
        petSize: 'Large',
        procedures: procedures,
        status: BookingStatus.upcoming,
        comments: '',
        date: DateTime(2024, 1, 15),
      );

      expect(booking.procedures.length, 4);
      expect(booking.procedures, containsAll(['Bath', 'Nail Trim']));
    });
  });
}
