import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late List<Booking> bookings;
  Booking? selectedBooking;

  static const List<int> _hours = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];

  @override
  void initState() {
    super.initState();
    bookings = todayBookings;
  }

  Booking? _getBookingForHour(int hour) {
    try {
      return bookings.firstWhere(
        (b) => b.startHour >= hour && b.startHour < hour + 1,
      );
    } catch (_) {
      return null;
    }
  }

  void _updateBookingStatus(Booking booking, BookingStatus newStatus) {
    setState(() {
      final index = bookings.indexOf(booking);
      if (index != -1) {
        final updated = Booking(
          id: booking.id,
          startTime: booking.startTime,
          endTime: booking.endTime,
          startHour: booking.startHour,
          duration: booking.duration,
          ownerName: booking.ownerName,
          ownerPhone: booking.ownerPhone,
          petName: booking.petName,
          petType: booking.petType,
          petSize: booking.petSize,
          procedures: booking.procedures,
          status: newStatus,
          comments: booking.comments,
        );
        bookings = List.from(bookings)..[index] = updated;
        selectedBooking = bookings[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("EEEE, d 'de' MMMM 'de' yyyy", 'pt_BR');
    final dateString = formatter.format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 58,
                  child: _buildScheduleCard(dateString),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 42,
                  child: _buildDetailsCard(),
                ),
              ],
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 500,
                child: _buildScheduleCard(dateString),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 600,
                child: _buildDetailsCard(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScheduleCard(String dateString) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScheduleHeader(dateString),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                padding: const EdgeInsets.only(right: 16),
                itemCount: _hours.length,
                itemBuilder: (context, index) {
                  final hour = _hours[index];
                  final booking = _getBookingForHour(hour);
                  final isLast = index == _hours.length - 1;
                  return _buildTimeSlot(hour, booking, isLast: isLast);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleHeader(String dateString) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Agenda de Hoje',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateString,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4A5565),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black.withOpacity(0.10)),
            ),
            child: Text(
              '${bookings.length} agendamentos',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(int hour, Booking? booking, {bool isLast = false}) {
    final hasBooking = booking != null;
    // Extra height for booking slots so the card content never overflows
    final slotHeight = hasBooking ? 180.0 : 80.0;
    final timeLabel = '${hour.toString().padLeft(2, '0')}:00';
    final isCompleted = booking?.status == BookingStatus.completed;

    return SizedBox(
      height: slotHeight,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Time label
          Positioned(
            left: 0,
            top: 6,
            child: Text(
              timeLabel,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6A7282),
              ),
            ),
          ),
          // Vertical line
          if (!isLast)
            Positioned(
              left: 80,
              top: 0,
              child: Container(
                width: 1,
                height: hasBooking ? slotHeight : 16,
                color: const Color(0xFFE5E7EB),
              ),
            ),
          // Dot
          Positioned(
            left: 76,
            top: 4,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFD1D5DC),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Booking card
          if (hasBooking)
            Positioned(
              left: 104,
              right: 0,
              top: 0,
              bottom: 16,
              child: GestureDetector(
                onTap: () => setState(() {
                  selectedBooking =
                      selectedBooking?.id == booking.id ? null : booking;
                }),
                child: Opacity(
                  opacity: isCompleted ? 0.6 : 1.0,
                  child: _buildTimelineCard(booking),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(Booking booking) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selectedBooking?.id == booking.id
              ? const Color(0xFF155DFC)
              : const Color(0xFFE5E7EB),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Time + status badge row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _statusIcon(booking.status),
                  const SizedBox(width: 8),
                  Text(
                    '${booking.startTime} - ${booking.endTime}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5565),
                    ),
                  ),
                ],
              ),
              _statusBadge(booking.status),
            ],
          ),
          const SizedBox(height: 8),
          // Pet row
          Row(
            children: [
              const _PetIcon(),
              const SizedBox(width: 8),
              Text(
                booking.petName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0A0A0A),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${booking.petType})',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4A5565),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Owner row
          Row(
            children: [
              const _OwnerIcon(),
              const SizedBox(width: 8),
              Text(
                booking.ownerName,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4A5565),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Service tags
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: booking.procedures.map((p) => _serviceTag(p)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(BookingStatus status) {
    switch (status) {
      case BookingStatus.completed:
        return const Icon(
          Icons.check_circle_outline,
          size: 16,
          color: Color(0xFF00A63E),
        );
      case BookingStatus.inProgress:
        return const Icon(
          Icons.play_circle_outline,
          size: 16,
          color: Color(0xFF155DFC),
        );
      case BookingStatus.upcoming:
        return const Icon(
          Icons.radio_button_unchecked,
          size: 16,
          color: Color(0xFF99A1AF),
        );
      case BookingStatus.cancelled:
        return const Icon(
          Icons.cancel_outlined,
          size: 16,
          color: Color(0xFFEF4444),
        );
    }
  }

  Widget _statusBadge(BookingStatus status) {
    late Color bg;
    late Color textColor;
    late String label;
    switch (status) {
      case BookingStatus.completed:
        bg = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF008236);
        label = 'Concluído';
        break;
      case BookingStatus.inProgress:
        bg = const Color(0xFFDBEAFE);
        textColor = const Color(0xFF1447E6);
        label = 'Em andamento';
        break;
      case BookingStatus.upcoming:
        bg = const Color(0xFFECEEF2);
        textColor = const Color(0xFF030213);
        label = 'Próximo';
        break;
      case BookingStatus.cancelled:
        bg = const Color(0xFFFEE2E2);
        textColor = const Color(0xFFDC2626);
        label = 'Cancelado';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _serviceTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFECEEF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF030213),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // Details / right-panel card
  // ──────────────────────────────────────────────────────────────

  Widget _buildDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 6),
            child: Text(
              'Detalhes & Ações',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0A),
              ),
            ),
          ),
          Expanded(
            child: selectedBooking == null
                ? _buildEmptyState()
                : _buildBookingDetails(selectedBooking!),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 64,
              color: Color(0xFFD1D5DC),
            ),
            SizedBox(height: 16),
            Text(
              'Selecione um agendamento',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A7282),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Clique em um agendamento na linha do tempo',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6A7282),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetails(Booking booking) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Status section ──────────────────────────────────────
          _buildStatusSection(booking),
          const SizedBox(height: 16),

          // ── Horário ─────────────────────────────────────────────
          _buildInfoCard(
            icon: const _ClockIcon(),
            title: 'Horário',
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                '${booking.startTime} - ${booking.endTime}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0A),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Informação do dono ───────────────────────────────────
          _buildInfoCard(
            icon: const Icon(
              Icons.person_outline,
              size: 20,
              color: Color(0xFF4A5565),
            ),
            title: 'Informação do dono',
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelValue('Nome', booking.ownerName),
                  const SizedBox(height: 12),
                  const Text(
                    'Celular',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5565),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        booking.ownerPhone,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone_outlined,
                          size: 16,
                          color: Color(0xFF0A0A0A),
                        ),
                        label: const Text(
                          'Ligar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0A0A0A),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          side: BorderSide(
                              color: Colors.black.withOpacity(0.10)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Informação do pet ────────────────────────────────────
          _buildInfoCard(
            icon: const Icon(
              Icons.pets,
              size: 20,
              color: Color(0xFF4A5565),
            ),
            title: 'Informação do pet',
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelValue('Nome', booking.petName),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tipo',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A5565),
                              ),
                            ),
                            Text(
                              booking.petType,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0A0A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tamanho',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A5565),
                              ),
                            ),
                            Text(
                              booking.petSize,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0A0A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Serviços ─────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Serviços',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      booking.procedures.map((p) => _serviceTag(p)).toList(),
                ),
              ],
            ),
          ),

          if (booking.comments.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Observações',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking.comments,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5565),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Gradient status action card ─────────────────────────────────
  Widget _buildStatusSection(Booking booking) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFEFF6FF), Color(0xFFF0FDF4)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFBEDBFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status do agendamento',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4A5565),
            ),
          ),
          const SizedBox(height: 12),
          // Three status buttons
          Row(
            children: [
              Expanded(
                child: _statusActionButton(
                  icon: Icons.radio_button_unchecked,
                  label: 'Próximo',
                  isActive: booking.status == BookingStatus.upcoming,
                  onTap: () =>
                      _updateBookingStatus(booking, BookingStatus.upcoming),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statusActionButton(
                  icon: Icons.play_circle_outline,
                  label: 'Iniciar',
                  isActive: booking.status == BookingStatus.inProgress,
                  onTap: () =>
                      _updateBookingStatus(booking, BookingStatus.inProgress),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statusActionButton(
                  icon: Icons.cancel_outlined,
                  label: 'Cancelar',
                  isActive: booking.status == BookingStatus.cancelled,
                  onTap: () =>
                      _updateBookingStatus(booking, BookingStatus.cancelled),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Concluir full-width button
          SizedBox(
            width: double.infinity,
            child: Material(
              color: const Color(0xFF030213),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () =>
                    _updateBookingStatus(booking, BookingStatus.completed),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Concluir',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive
                  ? const Color(0xFF155DFC)
                  : Colors.black.withOpacity(0.10),
              width: isActive ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive
                    ? const Color(0xFF155DFC)
                    : const Color(0xFF0A0A0A),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? const Color(0xFF155DFC)
                      : const Color(0xFF0A0A0A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Generic info card (Horário / Dono / Pet) ────────────────────
  Widget _buildInfoCard({
    required Widget icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _labelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF4A5565),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF0A0A0A),
          ),
        ),
      ],
    );
  }
}

// ── Small icon helpers ──────────────────────────────────────────────

class _ClockIcon extends StatelessWidget {
  const _ClockIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.access_time_outlined,
      size: 20,
      color: Color(0xFF155DFC),
    );
  }
}

class _PetIcon extends StatelessWidget {
  const _PetIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.pets, size: 16, color: Color(0xFF155DFC));
  }
}

class _OwnerIcon extends StatelessWidget {
  const _OwnerIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.person_outline, size: 14, color: Color(0xFF4A5565));
  }
}
