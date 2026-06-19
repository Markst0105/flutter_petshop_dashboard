import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking.dart';

class BookingRepository {
  final SupabaseClient supabaseClient;

  BookingRepository({required this.supabaseClient});

  Future<List<Booking>> getBookings() async {
    final response = await supabaseClient.from('booking').select('''
      bookingid,
      datebooking,
      timebooking,
      duration,
      pet (
        name,
        type,
        size,
        petowner (
          name,
          cellnumber
        )
      ),
      booking_service (
        servicename
      )
    ''').timeout(const Duration(seconds: 15));

    return _parseBookingsResponse(response as List);
  }

  Future<void> createPetOwner({
    required String cpf,
    required String name,
    required String cellNumber,
  }) async {
    await supabaseClient.from('petowner').insert({
      'cpf': cpf,
      'name': name,
      'cellnumber': cellNumber,
      'datebirth': '1990-01-01',
      'gender': 'Not Spec',
    });
  }

  Future<Map<String, dynamic>> createPet({
    required String cpf,
    required String name,
    required String type,
    required String race,
  }) async {
    final response = await supabaseClient
        .from('pet')
        .insert({
          'cpf': cpf,
          'type': type,
          'race': race,
          'size': 'medium',
          'datebirth': '2020-01-01',
          'weight': 5.0,
          'name': name,
        })
        .select('petid')
        .single();

    return response;
  }

  Future<bool> petOwnerExists(String cpf) async {
    final response = await supabaseClient
        .from('petowner')
        .select('cpf')
        .eq('cpf', cpf)
        .maybeSingle();

    return response != null;
  }

  Future<Map<String, dynamic>> createBooking({
    required int petId,
    required String date,
    required String time,
    required double duration,
  }) async {
    final response = await supabaseClient
        .from('booking')
        .insert({
          'petid': petId,
          'datebooking': date,
          'timebooking': time,
          'duration': duration,
        })
        .select('bookingid')
        .single();

    return response;
  }

  Future<void> createService({
    required String serviceName,
    required String sizeDestined,
    required int duration,
    required double price,
  }) async {
    await supabaseClient.from('service').insert({
      'servicename': serviceName,
      'sizedestined': sizeDestined,
      'duration': duration,
      'price': price,
    });
  }

  Future<bool> serviceExists(String serviceName) async {
    final response = await supabaseClient
        .from('service')
        .select('servicename')
        .eq('servicename', serviceName)
        .maybeSingle();

    return response != null;
  }

  Future<void> addBookingService({
    required int bookingId,
    required String serviceName,
  }) async {
    await supabaseClient.from('booking_service').insert({
      'bookingid': bookingId,
      'servicename': serviceName,
    });
  }

  List<Booking> _parseBookingsResponse(List response) {
    return response.map((b) {
      String ownerName = '';
      String ownerPhone = '';
      String petName = '';
      String petType = 'Unknown';
      String petSize = 'medium';
      List<String> procedures = [];

      var petObj = b['pet'];
      if (petObj != null) {
        petName = petObj['name'] ?? '';
        petType = petObj['type'] ?? 'Unknown';
        petSize = petObj['size'] ?? 'medium';

        var ownerObj = petObj['petowner'];
        if (ownerObj != null) {
          ownerName = ownerObj['name'] ?? '';
          ownerPhone = ownerObj['cellnumber'] ?? '';
        }
      }

      var servicesObj = b['booking_service'] as List?;
      if (servicesObj != null) {
        procedures = servicesObj.map((s) => s['servicename'].toString()).toList();
      }

      String dateStr = b['datebooking'].toString().split('T').first;
      DateTime parsedDate = DateTime.tryParse(dateStr) ?? DateTime.now();
      DateTime date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
      String time = b['timebooking'].toString();
      String startHourStr = time.length >= 5 ? time.substring(0, 5) : time;
      List<String> parts = startHourStr.split(':');
      double startHourD = 9.0;
      if (parts.length >= 2) {
        startHourD = double.tryParse(parts[0])! + (double.tryParse(parts[1])! / 60.0);
      }

      double bDuration = (b['duration'] ?? 1).toDouble();

      int dHours = bDuration.floor();
      int dMins = ((bDuration - dHours) * 60).round();
      int eHours = int.parse(parts[0]) + dHours;
      int eMins = int.parse(parts[1]) + dMins;
      if (eMins >= 60) {
        eHours += (eMins ~/ 60);
        eMins = eMins % 60;
      }
      String endTimeStr = '${eHours.toString().padLeft(2, '0')}:${eMins.toString().padLeft(2, '0')}';

      return Booking(
        id: b['bookingid'].toString(),
        ownerName: ownerName,
        ownerPhone: ownerPhone,
        petName: petName,
        petType: petType,
        petSize: petSize,
        startTime: startHourStr,
        endTime: endTimeStr,
        startHour: startHourD,
        duration: bDuration,
        procedures: procedures,
        status: BookingStatus.upcoming,
        comments: '',
        date: date,
      );
    }).toList();
  }
}
