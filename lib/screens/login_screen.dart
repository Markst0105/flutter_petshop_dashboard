import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Header(isLoggedIn: false),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo placeholder
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.pets,
                          size: 80,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Portal de gerenciamento para funcionários',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF364153),
                        ),
                      ),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _LoginButton(
                              label: 'Agenda',
                              icon: Icons.assignment,
                              color: Colors.blue,
                              onPressed: () => context
                                  .read<AppState>()
                                  .login('schedule'),
                            ),
                            const SizedBox(height: 16),
                            _LoginButton(
                              label: 'Calendário',
                              icon: Icons.calendar_today,
                              color: Colors.blue.shade100,
                              textColor: const Color(0xFF1447e6),
                              onPressed: () => context
                                  .read<AppState>()
                                  .login('calendar'),
                            ),
                            const SizedBox(height: 16),
                            _LoginButton(
                              label: 'Financeiro',
                              icon: Icons.wallet,
                              color: Colors.green.shade100,
                              textColor: const Color(0xFF008236),
                              onPressed: () => context
                                  .read<AppState>()
                                  .login('financial'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color? textColor;
  final VoidCallback onPressed;

  const _LoginButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = color.value > 0xFF808080;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: color,
        foregroundColor: textColor ?? (isDark ? Colors.white : Colors.black87),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
