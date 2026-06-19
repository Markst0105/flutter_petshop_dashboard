import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/models/service.dart';

void main() {
  group('Service', () {
    test('creates service with correct properties', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      expect(service.id, '1');
      expect(service.name, 'Banho');
      expect(service.smallPrice, 25);
      expect(service.mediumPrice, 35);
      expect(service.largePrice, 45);
    });

    group('getPrice', () {
      late Service service;

      setUp(() {
        service = Service(
          id: '1',
          name: 'Test Service',
          smallPrice: 10.0,
          mediumPrice: 20.0,
          largePrice: 30.0,
        );
      });

      test('returns small price for small size', () {
        expect(service.getPrice('small'), 10.0);
      });

      test('returns medium price for medium size', () {
        expect(service.getPrice('medium'), 20.0);
      });

      test('returns large price for large size', () {
        expect(service.getPrice('large'), 30.0);
      });

      test('returns medium price for unknown size', () {
        expect(service.getPrice('unknown'), 20.0);
      });

      test('returns medium price for empty string', () {
        expect(service.getPrice(''), 20.0);
      });

      test('returns medium price for null-like values', () {
        expect(service.getPrice('xl'), 20.0);
        expect(service.getPrice('xs'), 20.0);
      });
    });

    test('service with decimal prices', () {
      final service = Service(
        id: '2',
        name: 'Tosa',
        smallPrice: 30.50,
        mediumPrice: 45.75,
        largePrice: 60.99,
      );

      expect(service.getPrice('small'), 30.50);
      expect(service.getPrice('medium'), 45.75);
      expect(service.getPrice('large'), 60.99);
    });

    test('service with zero prices', () {
      final service = Service(
        id: '3',
        name: 'Free Service',
        smallPrice: 0.0,
        mediumPrice: 0.0,
        largePrice: 0.0,
      );

      expect(service.getPrice('small'), 0.0);
      expect(service.getPrice('medium'), 0.0);
      expect(service.getPrice('large'), 0.0);
    });
  });

  group('initialServices', () {
    test('contains 8 services', () {
      expect(initialServices.length, 8);
    });

    test('all services have valid ids', () {
      for (int i = 0; i < initialServices.length; i++) {
        expect(initialServices[i].id, (i + 1).toString());
      }
    });

    test('all services have non-empty names', () {
      for (final service in initialServices) {
        expect(service.name.isNotEmpty, true);
      }
    });

    test('all services have positive prices', () {
      for (final service in initialServices) {
        expect(service.smallPrice > 0, true);
        expect(service.mediumPrice > 0, true);
        expect(service.largePrice > 0, true);
      }
    });

    test('medium price is between small and large', () {
      for (final service in initialServices) {
        expect(service.mediumPrice >= service.smallPrice, true);
        expect(service.largePrice >= service.mediumPrice, true);
      }
    });

    test('banho service exists with correct pricing', () {
      final banhoService = initialServices.firstWhere((s) => s.name == 'Banho');
      expect(banhoService.smallPrice, 25);
      expect(banhoService.mediumPrice, 35);
      expect(banhoService.largePrice, 45);
    });

    test('tosa service exists with correct pricing', () {
      final tosaService = initialServices.firstWhere((s) => s.name == 'Tosa');
      expect(tosaService.smallPrice, 30);
      expect(tosaService.mediumPrice, 45);
      expect(tosaService.largePrice, 60);
    });

    test('services are unique by id', () {
      final ids = initialServices.map((s) => s.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('services are unique by name', () {
      final names = initialServices.map((s) => s.name).toList();
      expect(names.toSet().length, names.length);
    });

    test('corte de unhas has lowest small price', () {
      final corteService =
          initialServices.firstWhere((s) => s.name == 'Corte de Unhas');
      expect(corteService.smallPrice, 15);
    });

    test('tosa completa has highest prices', () {
      final tosaCom = initialServices.firstWhere((s) => s.name == 'Tosa Completa');
      expect(tosaCom.largePrice, 100);
    });
  });
}
