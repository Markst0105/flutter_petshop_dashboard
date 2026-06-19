import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/header.dart';

const _logoUrl =
    'https://cdn.builder.io/api/v1/image/assets%2Ff1af6bdc9b6340ed933494acecf65fe5%2F35678fcd6a6440e0b559add086501a11?format=webp&width=800&height=1200';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEFF6FF),
              Color(0xFFF0FDF4),
            ],
          ),
        ),
        child: Column(
          children: [
            const Header(isLoggedIn: false),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      Image.network(
                        _logoUrl,
                        width: 160,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Portal de gerenciamento para funcionários',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF364153),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 384),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _MenuButton.filled(
                              label: 'Agenda',
                              icon: _AgendaIcon(),
                              onPressed: () =>
                                  context.read<AppState>().login('schedule'),
                            ),
                            const SizedBox(height: 16),
                            _MenuButton.outlined(
                              label: 'Calendário',
                              icon: _CalendarIcon(),
                              borderColor: const Color(0xFFBEDBFF),
                              textColor: const Color(0xFF1447E6),
                              onPressed: () =>
                                  context.read<AppState>().login('calendar'),
                            ),
                            const SizedBox(height: 16),
                            _MenuButton.outlined(
                              label: 'Financeiro',
                              icon: _FinancialIcon(),
                              borderColor: const Color(0xFFB9F8CF),
                              textColor: const Color(0xFF008236),
                              onPressed: () =>
                                  context.read<AppState>().login('financial'),
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

class _MenuButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onPressed;
  final bool filled;
  final Color? borderColor;
  final Color? textColor;

  const _MenuButton.filled({
    required this.icon,
    required this.label,
    required this.onPressed,
  })  : filled = true,
        borderColor = null,
        textColor = null;

  const _MenuButton.outlined({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.borderColor,
    required this.textColor,
  }) : filled = false;

  @override
  Widget build(BuildContext context) {
    final shadow = BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 3,
      offset: const Offset(0, 1),
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF2B7FFF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: filled
              ? null
              : Border.all(color: borderColor!, width: 2),
          boxShadow: [shadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: filled ? Colors.white : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AgendaIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(painter: _AgendaIconPainter()),
    );
  }
}

class _AgendaIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.33
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width / 16;

    // Clipboard top
    final clipPath = Path()
      ..moveTo(10 * s, 1.33 * s)
      ..lineTo(6 * s, 1.33 * s)
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(5.33 * s, 1.33 * s, 5.33 * s, 2.67 * s),
        const Radius.circular(0.67),
      ));
    canvas.drawPath(clipPath, paint);

    // Clipboard body
    final bodyPath = Path()
      ..moveTo(10.67 * s, 2.67 * s)
      ..lineTo(12 * s, 2.67 * s)
      ..cubicTo(12.35 * s, 2.67 * s, 12.69 * s, 2.81 * s, 12.94 * s, 3.06 * s)
      ..cubicTo(13.19 * s, 3.31 * s, 13.33 * s, 3.65 * s, 13.33 * s, 4 * s)
      ..lineTo(13.33 * s, 13.33 * s)
      ..cubicTo(13.33 * s, 13.69 * s, 13.19 * s, 14.03 * s, 12.94 * s, 14.28 * s)
      ..cubicTo(12.69 * s, 14.53 * s, 12.35 * s, 14.67 * s, 12 * s, 14.67 * s)
      ..lineTo(4 * s, 14.67 * s)
      ..cubicTo(3.65 * s, 14.67 * s, 3.31 * s, 14.53 * s, 3.06 * s, 14.28 * s)
      ..cubicTo(2.81 * s, 14.03 * s, 2.67 * s, 13.69 * s, 2.67 * s, 13.33 * s)
      ..lineTo(2.67 * s, 4 * s)
      ..cubicTo(2.67 * s, 3.65 * s, 2.81 * s, 3.31 * s, 3.06 * s, 3.06 * s)
      ..cubicTo(3.31 * s, 2.81 * s, 3.65 * s, 2.67 * s, 4 * s, 2.67 * s)
      ..lineTo(5.33 * s, 2.67 * s);
    canvas.drawPath(bodyPath, paint);

    // Lines
    canvas.drawLine(Offset(8 * s, 7.33 * s), Offset(10.67 * s, 7.33 * s), paint);
    canvas.drawLine(Offset(8 * s, 10.67 * s), Offset(10.67 * s, 10.67 * s), paint);
    canvas.drawLine(Offset(5.33 * s, 7.33 * s), Offset(5.34 * s, 7.33 * s), paint);
    canvas.drawLine(Offset(5.33 * s, 10.67 * s), Offset(5.34 * s, 10.67 * s), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CalendarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(painter: _CalendarIconPainter()),
    );
  }
}

class _CalendarIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1447E6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.33
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width / 16;

    canvas.drawLine(Offset(5.33 * s, 1.33 * s), Offset(5.33 * s, 4 * s), paint);
    canvas.drawLine(Offset(10.67 * s, 1.33 * s), Offset(10.67 * s, 4 * s), paint);

    final bodyPath = Path()
      ..moveTo(12.67 * s, 2.67 * s)
      ..lineTo(3.33 * s, 2.67 * s)
      ..cubicTo(2.60 * s, 2.67 * s, 2 * s, 3.26 * s, 2 * s, 4 * s)
      ..lineTo(2 * s, 13.33 * s)
      ..cubicTo(2 * s, 14.07 * s, 2.60 * s, 14.67 * s, 3.33 * s, 14.67 * s)
      ..lineTo(12.67 * s, 14.67 * s)
      ..cubicTo(13.40 * s, 14.67 * s, 14 * s, 14.07 * s, 14 * s, 13.33 * s)
      ..lineTo(14 * s, 4 * s)
      ..cubicTo(14 * s, 3.26 * s, 13.40 * s, 2.67 * s, 12.67 * s, 2.67 * s)
      ..close();
    canvas.drawPath(bodyPath, paint);

    canvas.drawLine(Offset(2 * s, 6.67 * s), Offset(14 * s, 6.67 * s), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FinancialIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CustomPaint(painter: _FinancialIconPainter()),
    );
  }
}

class _FinancialIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF008236)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.33
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width / 16;

    final topPath = Path()
      ..moveTo(12.67 * s, 4.67 * s)
      ..lineTo(12.67 * s, 2.67 * s)
      ..cubicTo(12.67 * s, 2.49 * s, 12.60 * s, 2.32 * s, 12.47 * s, 2.20 * s)
      ..cubicTo(12.35 * s, 2.07 * s, 12.18 * s, 2 * s, 12 * s, 2 * s)
      ..lineTo(3.33 * s, 2 * s)
      ..cubicTo(2.98 * s, 2 * s, 2.64 * s, 2.14 * s, 2.39 * s, 2.39 * s)
      ..cubicTo(2.14 * s, 2.64 * s, 2 * s, 2.98 * s, 2 * s, 3.33 * s)
      ..cubicTo(2 * s, 3.69 * s, 2.14 * s, 4.03 * s, 2.39 * s, 4.28 * s)
      ..cubicTo(2.64 * s, 4.53 * s, 2.98 * s, 4.67 * s, 3.33 * s, 4.67 * s)
      ..lineTo(13.33 * s, 4.67 * s)
      ..cubicTo(13.51 * s, 4.67 * s, 13.68 * s, 4.74 * s, 13.80 * s, 4.86 * s)
      ..cubicTo(13.93 * s, 4.99 * s, 14 * s, 5.16 * s, 14 * s, 5.33 * s)
      ..lineTo(14 * s, 8 * s)
      ..moveTo(14 * s, 8 * s)
      ..lineTo(12 * s, 8 * s)
      ..cubicTo(11.65 * s, 8 * s, 11.31 * s, 8.14 * s, 11.06 * s, 8.39 * s)
      ..cubicTo(10.81 * s, 8.64 * s, 10.67 * s, 8.98 * s, 10.67 * s, 9.33 * s)
      ..cubicTo(10.67 * s, 9.69 * s, 10.81 * s, 10.03 * s, 11.06 * s, 10.28 * s)
      ..cubicTo(11.31 * s, 10.53 * s, 11.65 * s, 10.67 * s, 12 * s, 10.67 * s)
      ..lineTo(14 * s, 10.67 * s)
      ..cubicTo(14.18 * s, 10.67 * s, 14.35 * s, 10.60 * s, 14.47 * s, 10.47 * s)
      ..cubicTo(14.60 * s, 10.35 * s, 14.67 * s, 10.18 * s, 14.67 * s, 10 * s)
      ..lineTo(14.67 * s, 8.67 * s)
      ..cubicTo(14.67 * s, 8.49 * s, 14.60 * s, 8.32 * s, 14.47 * s, 8.20 * s)
      ..cubicTo(14.35 * s, 8.07 * s, 14.18 * s, 8 * s, 14 * s, 8 * s)
      ..close();
    canvas.drawPath(topPath, paint);

    final bottomPath = Path()
      ..moveTo(2 * s, 3.33 * s)
      ..lineTo(2 * s, 12.67 * s)
      ..cubicTo(2 * s, 13.02 * s, 2.14 * s, 13.36 * s, 2.39 * s, 13.61 * s)
      ..cubicTo(2.64 * s, 13.86 * s, 2.98 * s, 14 * s, 3.33 * s, 14 * s)
      ..lineTo(13.33 * s, 14 * s)
      ..cubicTo(13.51 * s, 14 * s, 13.68 * s, 13.93 * s, 13.80 * s, 13.80 * s)
      ..cubicTo(13.93 * s, 13.68 * s, 14 * s, 13.51 * s, 14 * s, 13.33 * s)
      ..lineTo(14 * s, 10.67 * s);
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
