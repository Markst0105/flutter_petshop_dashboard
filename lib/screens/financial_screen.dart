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

  String _sizeLabel(String size) {
    switch (size) {
      case 'small':
        return 'Pequeno';
      case 'large':
        return 'Grande';
      default:
        return 'Médio';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services table card
        Expanded(
          flex: 2,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0x1A000000)),
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Serviços e Preços',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          const Text(
                            'Tamanho pet:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0A0A0A),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 180,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F3F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedSize,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF0A0A0A),
                                ),
                                items: const [
                                  DropdownMenuItem(value: 'small', child: Text('Pequeno')),
                                  DropdownMenuItem(value: 'medium', child: Text('Médio')),
                                  DropdownMenuItem(value: 'large', child: Text('Grande')),
                                ],
                                onChanged: (value) {
                                  if (value != null) setState(() => selectedSize = value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0x1A000000)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Header row
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0x1A000000)),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: Text(
                                  'Serviço',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF0A0A0A),
                                  ),
                                ),
                              ),
                              _headerCell('Pequeno'),
                              _headerCell('Médio'),
                              _headerCell('Grande'),
                              const SizedBox(width: 90),
                            ],
                          ),
                        ),
                        // Data rows
                        ...services.asMap().entries.map((entry) {
                          final isLast = entry.key == services.length - 1;
                          final service = entry.value;
                          return Container(
                            decoration: BoxDecoration(
                              border: isLast
                                  ? null
                                  : const Border(
                                      bottom: BorderSide(color: Color(0x1A000000)),
                                    ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    service.name,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF0A0A0A),
                                    ),
                                  ),
                                ),
                                _priceCell(service.smallPrice),
                                _priceCell(service.mediumPrice),
                                _priceCell(service.largePrice),
                                SizedBox(
                                  width: 90,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: OutlinedButton.icon(
                                      onPressed: () => _addServiceToTotal(service),
                                      icon: const Icon(Icons.add, size: 16,
                                          color: Color(0xFF0A0A0A)),
                                      label: const Text(
                                        'Add',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF0A0A0A),
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 5),
                                        side: const BorderSide(
                                            color: Color(0x1A000000)),
                                        backgroundColor: Colors.white,
                                        minimumSize: const Size(74, 32),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Total panel card
        Expanded(
          flex: 1,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: Color(0x1A000000)),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Serviço total',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (selectedServices.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: const [
                          Text(
                            'Nenhum serviço adicionado',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6A7282),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Clique em "add" em qualquer serviço para incluir no total',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6A7282),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: selectedServices.map((s) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFEFF6FF), Color(0xFFF0FDF4)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFBEDBFF)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        s.service.name,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF0A0A0A),
                                        ),
                                      ),
                                      Text(
                                        _sizeLabel(s.size),
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF4A5565),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'R\$${s.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF0A0A0A),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _removeServiceFromTotal(s.id),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: 16,
                                    color: Color(0xFFFB2C36),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 4),
                  const Divider(color: Color(0x1A000000), thickness: 1),
                  const SizedBox(height: 17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      Text(
                        'R\$${_getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(() => selectedServices.clear()),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        side: const BorderSide(color: Color(0x1A000000)),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Limpar tudo',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String label) {
    return Expanded(
      flex: 2,
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0A0A0A),
        ),
      ),
    );
  }

  Widget _priceCell(double price) {
    return Expanded(
      flex: 2,
      child: Text(
        'R\$${price.toStringAsFixed(0)}',
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF0A0A0A),
        ),
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
