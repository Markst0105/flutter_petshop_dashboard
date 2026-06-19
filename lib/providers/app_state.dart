import 'dart:async';

import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../repositories/booking_repository.dart';
import '../utils/web_logger.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentScreen = 'schedule';
  List<Booking> _bookings = [];
  String _loadingStatus = 'Initializing...';
  String? _lastError;
  bool _isLoading = false;

  final BookingRepository repository;

  bool get isLoggedIn => _isLoggedIn;
  String get currentScreen => _currentScreen;
  List<Booking> get bookings => _bookings;
  String get loadingStatus => _loadingStatus;
  String? get lastError => _lastError;
  bool get isLoading => _isLoading;

  AppState({required this.repository}) {
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
      _bookings = await repository.getBookings();

      WebLogger.info('[Repository] Query successful, received ${_bookings.length} bookings');

      if (_bookings.isEmpty) {
        WebLogger.warn('[Repository] No bookings found, using fallback mock data');
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
      WebLogger.warn('[Repository] Timeout: $e');

      if (retryCount < 2) {
        WebLogger.info('[Repository] Retrying... (attempt ${retryCount + 1}/2)');
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

      WebLogger.error('[Repository] Error loading bookings', e);

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
