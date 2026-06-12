import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/models/service.dart';

void main() {
  group('Service Model', () {
    test('can create service with all fields', () {
      final service = Service(
        id: '1',
        name: 'Grooming',
      );

      expect(service.id, '1');
      expect(service.name, 'Grooming');
    });

    test('service can have different names', () {
      final groomingService = Service(
        id: '1',
        name: 'Grooming',
      );

      final bathService = Service(
        id: '2',
        name: 'Bath',
      );

      expect(groomingService.name, 'Grooming');
      expect(bathService.name, 'Bath');
      expect(groomingService.name, isNot(bathService.name));
    });

    test('service id is unique', () {
      final service1 = Service(
        id: '1',
        name: 'Grooming',
      );

      final service2 = Service(
        id: '2',
        name: 'Grooming',
      );

      expect(service1.id, isNot(service2.id));
    });

    test('multiple services can be created', () {
      final services = [
        Service(id: '1', name: 'Bath'),
        Service(id: '2', name: 'Grooming'),
        Service(id: '3', name: 'Nail Trim'),
        Service(id: '4', name: 'Teeth Cleaning'),
      ];

      expect(services.length, 4);
      expect(services.map((s) => s.name), containsAll(['Bath', 'Grooming']));
    });
  });
}
