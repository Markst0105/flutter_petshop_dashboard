import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentScreen = 'schedule'; // 'schedule', 'calendar', 'financial', 'create_booking'
  List<Booking> _bookings = []; // Initially empty, populated from Supabase

  bool get isLoggedIn => _isLoggedIn;
  String get currentScreen => _currentScreen;
  List<Booking> get bookings => _bookings;

  final SupabaseClient supabase = Supabase.instance.client;

  AppState() {
    loadBookings();
  }

  Future<void> loadBookings() async {
    try {
      // Joins bookings with associated pet owner and services to match our Booking model
      // Given the sql schema: booking has a foreign key to pet(petID).
      // And users_booking or booking_service can have links.
      // But for simple listing we will query `booking` and `pet`.
      // Using left join for `pet` and `petOwner`:
      final response = await supabase.from('booking').select('''
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
      ''');

      _bookings = (response as List).map((b) {
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

        // Extract the date part only before parsing, preventing timezone shifts
        String dateStr = b['datebooking'].toString().split('T').first;
        DateTime parsedDate = DateTime.tryParse(dateStr) ?? DateTime.now();
        DateTime date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
        String time = b['timebooking'].toString();
        // format expected by UI is "14:00"
        String startHourStr = time.length >= 5 ? time.substring(0, 5) : time;
        List<String> parts = startHourStr.split(':');
        double startHourD = 9.0;
        if (parts.length >= 2) {
          startHourD = double.tryParse(parts[0])! + (double.tryParse(parts[1])! / 60.0);
        }

        double bDuration = (b['duration'] ?? 1).toDouble();

        // calculate end time string
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
          status: BookingStatus.upcoming, // database doesn't have status yet
          comments: '', // database doesn't have comments
          date: date,
        );
      }).toList();

      // If no bookings from Supabase, use local bookings for today
      if (_bookings.isEmpty) {
        _bookings = todayBookings;
      }

      // Sort bookings by date and time
      _bookings.sort((a, b) {
        final dateComparison = a.date.compareTo(b.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return a.startHour.compareTo(b.startHour);
      });

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading bookings: $e');
      // Fallback to local bookings on error
      _bookings = todayBookings;
      notifyListeners();
    }
  }

  void login(String screen) {
    _isLoggedIn = true;
    _currentScreen = screen;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _currentScreen = 'schedule';
    notifyListeners();
  }

  void navigateToScreen(String screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void handleLogoClick() {
    _isLoggedIn = false;
    _currentScreen = 'schedule';
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    // Sort bookings by date and time
    _bookings.sort((a, b) {
      final dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) {
        return dateComparison;
      }
      return a.startHour.compareTo(b.startHour);
    });
    notifyListeners();
  }
}
