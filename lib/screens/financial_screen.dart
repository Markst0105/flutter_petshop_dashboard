import 'package:flutter/material.dart';
import '../models/service.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({Key? key}) : super(key: key);

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  late List<Service> services;
  String selectedSize = 'medium';
  List<SelectedService> selectedServices = [];

  @override
  void initState() {
    super.initState();
    services = List.from(initialServices);
  }

  void _addServiceToTotal(Service service) {
    final price = service.getPrice(selectedSize);
    final newService = SelectedService(
      id: '${service.id}-${DateTime.now().millisecondsSinceEpoch}',
      service: service,
      size: selectedSize,
      price: price,
    );
    setState(() {
      selectedServices.add(newService);
    });
  }

  void _removeServiceFromTotal(String id) {
    setState(() {
      selectedServices.removeWhere((s) => s.id == id);
    });
  }

  double _getTotalPrice() {
    return selectedServices.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Services table
          Expanded(
            flex: 2,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serviços e Preços',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Serviço')),
                          DataColumn(label: Text('Pequeno')),
                          DataColumn(label: Text('Médio')),
                          DataColumn(label: Text('Grande')),
                          DataColumn(label: Text('Ação')),
                        ],
                        rows: services
                            .map(
                              (service) => DataRow(
                                cells: [
                                  DataCell(Text(service.name)),
                                  DataCell(
                                    Text('R\$ ${service.smallPrice.toStringAsFixed(2)}'),
                                  ),
                                  DataCell(
                                    Text('R\$ ${service.mediumPrice.toStringAsFixed(2)}'),
                                  ),
                                  DataCell(
                                    Text('R\$ ${service.largePrice.toStringAsFixed(2)}'),
                                  ),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () => _addServiceToTotal(service),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: const Text('Adicionar'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Total section
          Expanded(
            flex: 1,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total de Serviços',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Size selector
                    Text(
                      'Tamanho do Pet',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(label: Text('P'), value: 'small'),
                        ButtonSegment(label: Text('M'), value: 'medium'),
                        ButtonSegment(label: Text('G'), value: 'large'),
                      ],
                      selected: {selectedSize},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          selectedSize = newSelection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    // Selected services list
                    Text(
                      'Serviços Selecionados',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    if (selectedServices.isEmpty)
                      Text(
                        'Nenhum serviço adicionado',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      )
                    else
                      Column(
                        children: selectedServices
                            .map(
                              (selectedService) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            selectedService.service.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            'R\$ ${selectedService.price.toStringAsFixed(2)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () =>
                                          _removeServiceFromTotal(
                                            selectedService.id,
                                          ),
                                      iconSize: 18,
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    // Total price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          'R\$ ${_getTotalPrice().toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedService {
  final String id;
  final Service service;
  final String size;
  final double price;

  SelectedService({
    required this.id,
    required this.service,
    required this.size,
    required this.price,
  });
}
