import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/supabase_diagnostics.dart';

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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFF0FDF4)],
        ),
        border: Border(
          bottom: BorderSide(color: Color(0xFFDBEAFE), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: widget.onLogoClick,
              child: Image.network(
                'https://cdn.builder.io/api/v1/image/assets%2Ff1af6bdc9b6340ed933494acecf65fe5%2F35678fcd6a6440e0b559add086501a11?format=webp&width=800&height=1200',
                width: 48,
                height: 48,
                fit: BoxFit.contain,
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
            // Diagnostics button (debug mode)
            if (widget.isLoggedIn)
              Tooltip(
                message: 'Run diagnostics',
                child: IconButton(
                  icon: const Icon(Icons.bug_report_outlined, size: 20),
                  onPressed: () => SupabaseDiagnostics.runDiagnostics(),
                  splashRadius: 24,
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
                        Expanded(
                          child: Text(
                            'Agenda',
                            style: TextStyle(
                              fontWeight: widget.currentScreen == 'schedule'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            'Calendário',
                            style: TextStyle(
                              fontWeight: widget.currentScreen == 'calendar'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                          Icons.attach_money,
                          color: widget.currentScreen == 'financial'
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Financeiro',
                            style: TextStyle(
                              fontWeight: widget.currentScreen == 'financial'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'create_booking',
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: widget.currentScreen == 'create_booking'
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Criar Agendamento',
                            style: TextStyle(
                              fontWeight: widget.currentScreen == 'create_booking'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            'Sair',
                            style: TextStyle(color: Colors.red.shade600),
                            overflow: TextOverflow.ellipsis,
                          ),
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
