import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:petshop_dashboard/repositories/booking_repository.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockPostgresQuery extends Mock implements PostgrestQuery {}

class MockPostgresQueryBuilder extends Mock implements PostgrestQueryBuilder {}

void main() {
  group('BookingRepository', () {
    late MockSupabaseClient mockSupabaseClient;
    late BookingRepository repository;

    setUp(() {
      mockSupabaseClient = MockSupabaseClient();
      repository = BookingRepository(supabaseClient: mockSupabaseClient);
    });

    group('getBookings', () {
      test('returns list of bookings when query succeeds', () async {
        final mockResponse = [
          {
            'bookingid': 1,
            'datebooking': '2024-01-15',
            'timebooking': '09:00:00',
            'duration': 1.0,
            'pet': {
              'name': 'Max',
              'type': 'Cachorro',
              'size': 'medium',
              'petowner': {
                'name': 'John Doe',
                'cellnumber': '(11) 98765-4321'
              }
            },
            'booking_service': [
              {'servicename': 'Banho'}
            ]
          }
        ];

        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('booking')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select(any())).thenReturn(mockQuery);
        when(() => mockQuery.timeout(any())).thenAnswer((_) async => mockResponse);

        final bookings = await repository.getBookings();

        expect(bookings, isNotEmpty);
        expect(bookings.first.petName, 'Max');
        expect(bookings.first.ownerName, 'John Doe');
        expect(bookings.first.procedures, contains('Banho'));
      });

      test('returns empty list when no bookings found', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('booking')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select(any())).thenReturn(mockQuery);
        when(() => mockQuery.timeout(any())).thenAnswer((_) async => []);

        final bookings = await repository.getBookings();

        expect(bookings, isEmpty);
      });

      test('throws error when query fails', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('booking')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select(any())).thenReturn(mockQuery);
        when(() => mockQuery.timeout(any())).thenThrow(Exception('Database error'));

        expect(
          () => repository.getBookings(),
          throwsException,
        );
      });
    });

    group('createPetOwner', () {
      test('successfully creates pet owner', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('petowner')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.insert(any())).thenReturn(mockQuery);
        when(() => mockQuery.select(any())).thenReturn(mockQuery);

        await repository.createPetOwner(
          cpf: '12345678901',
          name: 'John Doe',
          cellNumber: '(11) 98765-4321',
        );

        verify(() => mockSupabaseClient.from('petowner')).called(1);
        verify(() => mockQueryBuilder.insert(any())).called(1);
      });
    });

    group('petOwnerExists', () {
      test('returns true when pet owner exists', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('petowner')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select('cpf')).thenReturn(mockQuery);
        when(() => mockQuery.eq('cpf', '12345678901')).thenReturn(mockQuery);
        when(() => mockQuery.maybeSingle()).thenAnswer((_) async => {'cpf': '12345678901'});

        final exists = await repository.petOwnerExists('12345678901');

        expect(exists, true);
      });

      test('returns false when pet owner does not exist', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('petowner')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select('cpf')).thenReturn(mockQuery);
        when(() => mockQuery.eq('cpf', '99999999999')).thenReturn(mockQuery);
        when(() => mockQuery.maybeSingle()).thenAnswer((_) async => null);

        final exists = await repository.petOwnerExists('99999999999');

        expect(exists, false);
      });
    });

    group('createPet', () {
      test('successfully creates pet and returns pet id', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('pet')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.insert(any())).thenReturn(mockQuery);
        when(() => mockQuery.select('petid')).thenReturn(mockQuery);
        when(() => mockQuery.single()).thenAnswer((_) async => {'petid': 123});

        final result = await repository.createPet(
          cpf: '12345678901',
          name: 'Max',
          type: 'Cachorro',
          race: 'Poodle',
        );

        expect(result['petid'], 123);
      });
    });

    group('createBooking', () {
      test('successfully creates booking and returns booking id', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('booking')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.insert(any())).thenReturn(mockQuery);
        when(() => mockQuery.select('bookingid')).thenReturn(mockQuery);
        when(() => mockQuery.single()).thenAnswer((_) async => {'bookingid': 456});

        final result = await repository.createBooking(
          petId: 123,
          date: '2024-01-15',
          time: '09:00:00',
          duration: 1.0,
        );

        expect(result['bookingid'], 456);
      });
    });

    group('serviceExists', () {
      test('returns true when service exists', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('service')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select('servicename')).thenReturn(mockQuery);
        when(() => mockQuery.eq('servicename', 'Banho')).thenReturn(mockQuery);
        when(() => mockQuery.maybeSingle()).thenAnswer((_) async => {'servicename': 'Banho'});

        final exists = await repository.serviceExists('Banho');

        expect(exists, true);
      });

      test('returns false when service does not exist', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('service')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.select('servicename')).thenReturn(mockQuery);
        when(() => mockQuery.eq('servicename', 'NonExistent')).thenReturn(mockQuery);
        when(() => mockQuery.maybeSingle()).thenAnswer((_) async => null);

        final exists = await repository.serviceExists('NonExistent');

        expect(exists, false);
      });
    });

    group('addBookingService', () {
      test('successfully adds service to booking', () async {
        final mockQuery = MockPostgresQuery();
        final mockQueryBuilder = MockPostgresQueryBuilder();

        when(() => mockSupabaseClient.from('booking_service')).thenReturn(mockQueryBuilder);
        when(() => mockQueryBuilder.insert(any())).thenReturn(mockQuery);

        await repository.addBookingService(
          bookingId: 456,
          serviceName: 'Banho',
        );

        verify(() => mockSupabaseClient.from('booking_service')).called(1);
        verify(() => mockQueryBuilder.insert(any())).called(1);
      });
    });
  });
}
