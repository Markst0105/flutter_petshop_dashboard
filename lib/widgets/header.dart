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

  Widget _buildLogo() {
    return GestureDetector(
      onTap: widget.onLogoClick,
      child: Image.network(
        'https://cdn.builder.io/api/v1/image/assets%2Ff1af6bdc9b6340ed933494acecf65fe5%2F35678fcd6a6440e0b559add086501a11?format=webp&width=800&height=1200',
        width: 48,
        height: 48,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String dateString) {
    if (widget.isLoggedIn) {
      return Expanded(
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
      );
    } else {
      return Expanded(
        child: Text(
          'AgendaPet',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    }
  }

  PopupMenuItem<String> _buildMenuItem(
    BuildContext context,
    String value,
    IconData icon,
    String text, {
    bool isDestructive = false,
  }) {
    final isSelected = widget.currentScreen == value;
    final color = isDestructive
        ? Colors.red.shade600
        : isSelected
            ? Colors.blue.shade600
            : Colors.grey.shade600;

    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isDestructive ? Colors.red.shade600 : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(BuildContext context) {
    return [
      _buildMenuItem(context, 'schedule', Icons.assignment, 'Agenda'),
      _buildMenuItem(context, 'calendar', Icons.calendar_today, 'Calendário'),
      _buildMenuItem(context, 'financial', Icons.attach_money, 'Financeiro'),
      _buildMenuItem(context, 'create_booking', Icons.add, 'Criar Agendamento'),
      const PopupMenuDivider(),
      _buildMenuItem(context, 'logout', Icons.logout, 'Sair', isDestructive: true),
    ];
  }

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
            _buildLogo(),
            const SizedBox(width: 16),
            _buildTitle(context, dateString),
            if (widget.isLoggedIn)
              Tooltip(
                message: 'Run diagnostics',
                child: IconButton(
                  icon: const Icon(Icons.bug_report_outlined, size: 20),
                  onPressed: () => SupabaseDiagnostics.runDiagnostics(),
                  splashRadius: 24,
                ),
              ),
            if (widget.isLoggedIn)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    widget.onLogout?.call();
                  } else {
                    widget.onNavigate?.call(value);
                  }
                },
                itemBuilder: _buildMenuItems,
                child: const Icon(Icons.menu),
              ),
          ],
        ),
      ),
    );
  }
}
