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
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0x1a000000),
                  width: 1,
                ),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Serviços e Preços',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF0A0A0A),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Text(
                              'Tamanho pet:',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0A0A0A),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                value: selectedSize,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'small',
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text('Pequeno'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'medium',
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text('Médio'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'large',
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      child: Text('Grande'),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedSize = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0x1a000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 40,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Serviço',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A0A0A),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Pequeno',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A0A0A),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Médio',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A0A0A),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Grande',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A0A0A),
                                ),
                              ),
                            ),
                            const DataColumn(label: SizedBox(width: 74)),
                          ],
                          rows: services
                              .map(
                                (service) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        service.name,
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF0A0A0A),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        'R\$${service.smallPrice.toStringAsFixed(0)}',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF0A0A0A),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        'R\$${service.mediumPrice.toStringAsFixed(0)}',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF0A0A0A),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        'R\$${service.largePrice.toStringAsFixed(0)}',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF0A0A0A),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      OutlinedButton.icon(
                                        onPressed: () => _addServiceToTotal(service),
                                        icon: const Icon(Icons.add, size: 16),
                                        label: const Text('Add'),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 11,
                                            vertical: 5,
                                          ),
                                          side: const BorderSide(
                                            color: Color(0x1a000000),
                                            width: 1,
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Total section
          Expanded(
            flex: 1,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: Color(0x1a000000),
                  width: 1,
                ),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serviço total',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF0A0A0A),
                      ),
                    ),
                    const SizedBox(height: 48),
                    if (selectedServices.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Nenhum serviço adicionado',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF6A7282),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Clique em "add" em qualquer serviço para incluir no total',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF6A7282),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...selectedServices.map(
                            (selectedService) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          selectedService.service.name,
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: const Color(0xFF0A0A0A),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          'R\$ ${selectedService.price.toStringAsFixed(2)}',
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: const Color(0xFF6A7282),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 18),
                                    onPressed: () =>
                                        _removeServiceFromTotal(selectedService.id),
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    color: const Color(0xFF0A0A0A),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A0A0A),
                                ),
                              ),
                              Text(
                                'R\$ ${_getTotalPrice().toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0A0A0A),
                                ),
                              ),
                            ],
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
