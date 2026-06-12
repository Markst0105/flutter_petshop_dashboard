import 'package:flutter_test/flutter_test.dart';
import 'package:petshop_dashboard/models/service.dart';

void main() {
  group('Service Model - Price Calculator', () {
    test('can create service with prices for each pet size', () {
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

    test('getPrice returns correct price for small pet', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      expect(service.getPrice('small'), 25);
    });

    test('getPrice returns correct price for medium pet', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      expect(service.getPrice('medium'), 35);
    });

    test('getPrice returns correct price for large pet', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      expect(service.getPrice('large'), 45);
    });

    test('getPrice returns medium price for unknown size', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      expect(service.getPrice('unknown'), 35);
    });

    test('different services have different prices', () {
      final banho = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      final tosa = Service(
        id: '2',
        name: 'Tosa',
        smallPrice: 30,
        mediumPrice: 45,
        largePrice: 60,
      );

      expect(banho.getPrice('small'), lessThan(tosa.getPrice('small')));
      expect(banho.getPrice('large'), lessThan(tosa.getPrice('large')));
    });

    test('price increases with pet size', () {
      final service = Service(
        id: '1',
        name: 'Banho',
        smallPrice: 25,
        mediumPrice: 35,
        largePrice: 45,
      );

      final smallPrice = service.getPrice('small');
      final mediumPrice = service.getPrice('medium');
      final largePrice = service.getPrice('large');

      expect(smallPrice, lessThan(mediumPrice));
      expect(mediumPrice, lessThan(largePrice));
    });
  });
}
