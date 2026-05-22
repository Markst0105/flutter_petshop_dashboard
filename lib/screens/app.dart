import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'login_screen.dart';
import 'schedule_screen.dart';
import 'calendar_screen.dart';
import 'financial_screen.dart';
import '../widgets/header.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        if (!appState.isLoggedIn) {
          return const LoginScreen();
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade50.withOpacity(0.3),
                  Colors.green.shade50.withOpacity(0.3),
                ],
              ),
            ),
            child: Column(
              children: [
                Header(
                  isLoggedIn: appState.isLoggedIn,
                  currentScreen: appState.currentScreen,
                  onNavigate: (screen) =>
                      appState.navigateToScreen(screen),
                  onLogoClick: () => appState.handleLogoClick(),
                  onLogout: () => appState.logout(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: _buildScreen(appState.currentScreen),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScreen(String screen) {
    switch (screen) {
      case 'schedule':
        return const ScheduleScreen();
      case 'calendar':
        return const CalendarScreen();
      case 'financial':
        return const FinancialScreen();
      default:
        return const ScheduleScreen();
    }
  }
}
