import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking.dart';
import '../utils/web_logger.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentScreen = 'schedule';
  List<Booking> _bookings = [];
  String _loadingStatus = 'Initializing...';
  String? _lastError;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  String get currentScreen => _currentScreen;
  List<Booking> get bookings => _bookings;
  String get loadingStatus => _loadingStatus;
  String? get lastError => _lastError;
  bool get isLoading => _isLoading;

  final SupabaseClient supabase = Supabase.instance.client;

  AppState() {
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    WebLogger.info('AppState initializing...');
    await Future.delayed(const Duration(milliseconds: 500));
    WebLogger.info('Supabase client ready, loading bookings...');
    loadBookings();
  }

  Future<void> loadBookings({int retryCount = 0}) async {
    _isLoading = true;
    _loadingStatus = 'Loading bookings...';
    _lastError = null;
    notifyListeners();

    try {
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
      ''').timeout(const Duration(seconds: 15));

      WebLogger.info('[Supabase] Query successful, received ${(response as List).length} bookings');

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

      if (_bookings.isEmpty) {
        WebLogger.warn('[Supabase] No bookings found, using fallback mock data');
        _bookings = todayBookings;
      }

      _bookings.sort((a, b) {
        final dateComparison = a.date.compareTo(b.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return a.startHour.compareTo(b.startHour);
      });

      _loadingStatus = 'Bookings loaded successfully';
      _isLoading = false;
      notifyListeners();
    } on TimeoutException catch (e) {
      _lastError = 'Connection timeout. Server took too long to respond.';
      WebLogger.warn('[Supabase] Timeout: $e');

      if (retryCount < 2) {
        WebLogger.info('[Supabase] Retrying... (attempt ${retryCount + 1}/2)');
        await Future.delayed(Duration(seconds: 2 * (retryCount + 1)));
        await loadBookings(retryCount: retryCount + 1);
      } else {
        _bookings = todayBookings;
        _loadingStatus = 'Using offline data (connection timeout)';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      final errorMessage = e.toString();
      _lastError = errorMessage;
      _isLoading = false;

      WebLogger.error('[Supabase] Error loading bookings', e);

      if (errorMessage.contains('Failed host lookup') || errorMessage.contains('No such host')) {
        _loadingStatus = 'Network Error: Cannot reach Supabase. Check your internet connection or DNS settings.';
        WebLogger.warn('DNS/Network issue detected');
      } else if (errorMessage.contains('CORS') || errorMessage.contains('401') || errorMessage.contains('403')) {
        _loadingStatus = 'Access Error: CORS configuration or authentication issue.';
        WebLogger.warn('CORS or authentication issue detected');
      } else if (errorMessage.contains('Connection refused')) {
        _loadingStatus = 'Connection Error: Unable to connect to Supabase.';
        WebLogger.warn('Connection refused');
      } else {
        _loadingStatus = 'Error: ${errorMessage.split('\n').first}';
      }

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
