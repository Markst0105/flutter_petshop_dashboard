import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatefulWidget {
  final bool isLoggedIn;
  final String currentScreen;
  final Function(String)? onNavigate;
  final VoidCallback? onLogoClick;
  final VoidCallback? onLogout;

  const Header({
    Key? key,
    required this.isLoggedIn,
    this.currentScreen = 'schedule',
    this.onNavigate,
    this.onLogoClick,
    this.onLogout,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('EEEE, d \'de\' MMMM', 'pt_BR');
    final dateString = formatter.format(DateTime.now());

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: widget.onLogoClick,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.pets,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Title and Date
            if (widget.isLoggedIn)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hoje',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1a202c),
                      ),
                    ),
                    Text(
                      dateString,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Text(
                  'AgendaPet',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            // Menu button
            if (widget.isLoggedIn)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    widget.onLogout?.call();
                  } else {
                    widget.onNavigate?.call(value);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'schedule',
                    child: Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: widget.currentScreen == 'schedule'
                              ? Colors.blue.shade600
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Agenda',
                          style: TextStyle(
                            fontWeight: widget.currentScreen == 'schedule'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'calendar',
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: widget.currentScreen == 'calendar'
                              ? Colors.blue.shade600
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Calendário',
                          style: TextStyle(
                            fontWeight: widget.currentScreen == 'calendar'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'financial',
                    child: Row(
                      children: [
                        Icon(
                          Icons.wallet,
                          color: widget.currentScreen == 'financial'
                              ? Colors.blue.shade600
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Financeiro',
                          style: TextStyle(
                            fontWeight: widget.currentScreen == 'financial'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red.shade600,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Sair',
                          style: TextStyle(color: Colors.red.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
                child: const Icon(Icons.menu),
              ),
          ],
        ),
      ),
    );
  }
}
