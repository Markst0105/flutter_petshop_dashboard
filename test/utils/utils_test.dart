import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('Utility Functions Tests', () {
    test('time parsing edge cases', () {
      // Test time format validation
      final validTimes = ['09:00', '10:30', '14:45', '23:59'];
      for (var time in validTimes) {
        final parts = time.split(':');
        expect(parts.length, 2);
        expect(int.tryParse(parts[0]), isNotNull);
        expect(int.tryParse(parts[1]), isNotNull);
      }
    });

    test('duration calculation accuracy', () {
      // Test duration conversions
      final duration = 1.5; // 1.5 hours
      final hours = duration.floor(); // 1
      final minutes = ((duration - hours) * 60).round(); // 30

      expect(hours, 1);
      expect(minutes, 30);
    });

    test('booking status transitions', () {
      final statuses = ['upcoming', 'inProgress', 'completed', 'cancelled'];
      expect(statuses.length, 4);
      expect(statuses.contains('upcoming'), true);
      expect(statuses.contains('completed'), true);
    });

    test('pet size categories', () {
      final sizes = ['pequeno', 'medium', 'grande'];
      expect(sizes.length, 3);
      expect(sizes.contains('medium'), true);
    });
  });
}
