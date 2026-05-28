import 'package:flutter/foundation.dart';
import '../models/booking.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentScreen = 'schedule'; // 'schedule', 'calendar', 'financial', 'create_booking'
  final List<Booking> _bookings = todayBookings;

  bool get isLoggedIn => _isLoggedIn;
  String get currentScreen => _currentScreen;
  List<Booking> get bookings => _bookings;

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
