class Service {
  final String id;
  final String name;
  final double smallPrice;
  final double mediumPrice;
  final double largePrice;

  Service({
    required this.id,
    required this.name,
    required this.smallPrice,
    required this.mediumPrice,
    required this.largePrice,
  });

  double getPrice(String size) {
    switch (size) {
      case 'small':
        return smallPrice;
      case 'medium':
        return mediumPrice;
      case 'large':
        return largePrice;
      default:
        return mediumPrice;
    }
  }
}

final initialServices = [
  Service(
    id: '1',
    name: 'Banho',
    smallPrice: 25,
    mediumPrice: 35,
    largePrice: 45,
  ),
  Service(
    id: '2',
    name: 'Tosa',
    smallPrice: 30,
    mediumPrice: 45,
    largePrice: 60,
  ),
  Service(
    id: '3',
    name: 'Corte de Unhas',
    smallPrice: 15,
    mediumPrice: 20,
    largePrice: 25,
  ),
  Service(
    id: '4',
    name: 'Limpeza de Dentes',
    smallPrice: 40,
    mediumPrice: 50,
    largePrice: 60,
  ),
  Service(
    id: '5',
    name: 'Limpeza de Orelhas',
    smallPrice: 20,
    mediumPrice: 25,
    largePrice: 30,
  ),
  Service(
    id: '6',
    name: 'Tosa Completa',
    smallPrice: 60,
    mediumPrice: 80,
    largePrice: 100,
  ),
  Service(
    id: '7',
    name: 'Remoção de Subpelo',
    smallPrice: 35,
    mediumPrice: 50,
    largePrice: 65,
  ),
  Service(
    id: '8',
    name: 'Tratamento Antipulgas',
    smallPrice: 25,
    mediumPrice: 35,
    largePrice: 45,
  ),
];
