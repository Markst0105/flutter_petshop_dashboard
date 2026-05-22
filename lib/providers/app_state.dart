import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _currentScreen = 'schedule'; // 'schedule', 'calendar', 'financial'

  bool get isLoggedIn => _isLoggedIn;
  String get currentScreen => _currentScreen;

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
}
