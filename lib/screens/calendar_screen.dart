import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/booking.dart';

class DayBooking {
  final String id;
  final String time;
  final String duration;
  final String description;
  final String petName;
  final String petType;
  final String ownerName;
  final String ownerPhone;
  final String petSize;

  DayBooking({
    required this.id,
    required this.time,
    required this.duration,
    required this.description,
    required this.petName,
    required this.petType,
    required this.ownerName,
    required this.ownerPhone,
    required this.petSize,
  });
}

// Emptied mock data, now using database state dynamically
final Map<String, List<DayBooking>> dayBookings = {};

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  String? _expandedBookingId;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final firstDay = DateTime(2026, 1, 1);
    final lastDay = DateTime(2026, 12, 31);
    _focusedDay =
        now.isAfter(firstDay) && now.isBefore(lastDay) ? now : firstDay;
    _selectedDay = _focusedDay;
  }

  Color _getDensityColor(int density) {
    if (density == 0) return Colors.transparent;
    if (density <= 2) return Colors.yellow.shade200;
    if (density <= 4) return Colors.orange.shade300;
    return Colors.red.shade400;
  }

  Color _getDensityHoverColor(int density) {
    if (density == 0) return Colors.transparent;
    if (density <= 2) return Colors.yellow.shade300;
    if (density <= 4) return Colors.orange.shade400;
    return Colors.red.shade500;
  }

  List<DayBooking> _getBookingsForDate(DateTime date, List<Booking> appBindings) {
    // Filter bookings for the exact date
    final dateBookings = appBindings.where((b) => 
        b.date.year == date.year && 
        b.date.month == date.month && 
        b.date.day == date.day).toList();
        
    // Map them to the UI DayBooking representation
    return dateBookings.map((b) {
      String durationStr = '';
      if (b.duration == 1.0) {
        durationStr = '1 hora';
      } else {
        durationStr = '${b.duration} minutos';
      }

      String desc = b.procedures.isNotEmpty ? b.procedures.join(', ') : 'Agendamento';

      String formattedTime = b.startTime;

      return DayBooking(
        id: b.id,
        time: formattedTime,
        duration: durationStr,
        description: desc,
        petName: b.petName,
        petType: b.petType,
        ownerName: b.ownerName,
        ownerPhone: b.ownerPhone,
        petSize: b.petSize,
      );
    }).toList();
  }

  int _getBookingCount(DateTime date, List<Booking> appBindings) {
    return _getBookingsForDate(date, appBindings).length;
  }

  @override
  Widget build(BuildContext context) {
    final appBindings = Provider.of<AppState>(context).bookings;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final bookingsForSelectedDay = _getBookingsForDate(_selectedDay, appBindings);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: isMobile
            ? _buildMobileLayout(bookingsForSelectedDay, appBindings)
            : _buildDesktopLayout(bookingsForSelectedDay, appBindings),
      ),
    );
  }

  Widget _buildMobileLayout(List<DayBooking> bookings, List<Booking> appBindings) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 400),
            child: _buildCalendarCard(appBindings),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 400,
            child: _buildBookingsCard(bookings),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(List<DayBooking> bookings, List<Booking> appBindings) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: _buildCalendarCard(appBindings),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 800,
            child: _buildBookingsCard(bookings),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard(List<Booking> appBindings) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Calendário mensal',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dias são coloridos baseados na desidade de agendamentos: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDensityLegendItem(
                      Colors.yellow.shade200, 'Baixo (1-2)'),
                  const SizedBox(width: 16),
                  _buildDensityLegendItem(
                      Colors.orange.shade300, 'Médio (3-4)'),
                  const SizedBox(width: 16),
                  _buildDensityLegendItem(Colors.red.shade400, 'Alto (5+)'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TableCalendar(
              firstDay: DateTime(2026, 1, 1),
              lastDay: DateTime(2026, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _expandedBookingId = null;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final count = _getBookingCount(day, appBindings);
                  return Container(
                    decoration: BoxDecoration(
                      color: _getDensityColor(count),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: count > 4 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final count = _getBookingCount(day, appBindings);
                  return Container(
                    decoration: BoxDecoration(
                      color: _getDensityColor(count),
                      border: Border.all(
                        color: Colors.blue.shade500,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: count > 4 ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final count = _getBookingCount(day, appBindings);
                  return Container(
                    decoration: BoxDecoration(
                      color: _getDensityColor(count),
                      border: Border.all(
                        color: Colors.blue.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: count > 4 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
              calendarStyle: const CalendarStyle(
                cellMargin: EdgeInsets.all(6),
                outsideDaysVisible: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDensityLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildBookingsCard(List<DayBooking> bookings) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agendamentos para ${_selectedDay.day} de ${_getMonthName(_selectedDay.month)} de ${_selectedDay.year}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: bookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 48,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum agendamento',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final isExpanded = _expandedBookingId == booking.id;
                      return _buildBookingCard(booking, isExpanded);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(DayBooking booking, bool isExpanded) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              if (_expandedBookingId == booking.id) {
                _expandedBookingId = null;
              } else {
                _expandedBookingId = booking.id;
              }
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade50,
                  Colors.green.shade50,
                ],
              ),
              border: Border.all(color: Colors.blue.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${booking.petName} - ${booking.petType}',
                            style: Theme.of(context).textTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  booking.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Duração: ${booking.duration}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 12),
                  Divider(
                    height: 12,
                    color: Colors.blue.shade200,
                  ),
                  const SizedBox(height: 8),
                  _buildOwnerInfo(booking),
                  const SizedBox(height: 12),
                  _buildPetInfo(booking),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOwnerInfo(DayBooking booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person,
              size: 14,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              'Dono',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.ownerName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Text(
                    booking.ownerPhone,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle call action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ligando para ${booking.ownerPhone}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.phone, size: 14),
                    label: const Text('Ligar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetInfo(DayBooking booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.pets,
              size: 14,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              'Pet',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            'Tamanho: ${booking.petSize}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];
    return months[month - 1];
  }
}

