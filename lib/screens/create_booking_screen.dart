import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking.dart';
import '../models/service.dart';
import '../providers/app_state.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({Key? key}) : super(key: key);

  @override
  _CreateBookingScreenState createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form fields
  String _ownerCpf = '';
  String _ownerName = '';
  String _ownerPhone = '';
  String _petName = '';
  String _petSpecies = 'Cachorro';
  String _petBreed = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _observations = '';
  final List<Service> _selectedServices = [];

  final List<Service> _services = initialServices;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        final supabase = Supabase.instance.client;

        // 1. Insert or get pet owner
        // Check if pet owner exists
        final ownerRes = await supabase
            .from('petowner')
            .select('cpf')
            .eq('cpf', _ownerCpf)
            .maybeSingle();

        if (ownerRes == null) {
          // Insert new pet owner
          await supabase.from('petowner').insert({
            'cpf': _ownerCpf,
            'name': _ownerName,
            'cellnumber': _ownerPhone,
            'datebirth': '1990-01-01', // Default value as it's required in schema
            'gender': 'Not Spec', // Default value
          });
        }

        // 2. Insert pet (We assume a new pet for simplicity, or we can check by name)
        final petRes = await supabase
            .from('pet')
            .insert({
              'cpf': _ownerCpf,
              'type': _petSpecies,
              'race': _petBreed,
              'size': 'medium', // Default
              'datebirth': '2020-01-01', // Default
              'weight': 5.0, // Default  
              'name': _petName,
            })
            .select('petid')
            .single();

        final petID = petRes['petid'];

        // 3. Insert booking
        final String startTimeStr = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00';
        
        final bookingRes = await supabase
            .from('booking')
            .insert({
              'petid': petID,
              'datebooking': DateFormat('yyyy-MM-dd').format(_selectedDate),
              'timebooking': startTimeStr,
              'duration': 1, // Default duration
            })
            .select('bookingid')
            .single();

        final bookingID = bookingRes['bookingid'];

        // 4. Insert booking services
        for (var service in _selectedServices) {
          // Ensure the service exists in `service` table first (optional, maybe we should skip or use dummy)
          // Based on schema, serviceName is a foreign key. 
          // So we should just insert dummy services to the `service` table if they don't exist.
          final serviceExist = await supabase
              .from('service')
              .select('servicename')
              .eq('servicename', service.name)
              .maybeSingle();
              
          if (serviceExist == null) {
             await supabase.from('service').insert({
                'servicename': service.name,
                'sizedestined': 'medium',
                'duration': 1,
                'price': 50.0
             });
          }

          await supabase.from('booking_service').insert({
            'bookingid': bookingID,
            'servicename': service.name,
          });
        }

        // Update local state by reloading bookings
        await Provider.of<AppState>(context, listen: false).loadBookings();

        if (mounted) {
          Provider.of<AppState>(context, listen: false).navigateToScreen('calendar');
        }
      } catch (e) {
        debugPrint('Error inserting booking: $e');
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao criar agendamento: $e')));
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x1A000000)),
      ),
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false)
                        .navigateToScreen('calendar');
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Criar Agendamento',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Detalhes do Dono',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'CPF do Dono'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o CPF do dono.';
                }
                return null; // Basic validation, can be improved
              },
              onSaved: (value) => _ownerCpf = value!,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome do Dono'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do dono.';
                }
                return null;
              },
              onSaved: (value) => _ownerName = value!,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Telefone do Dono'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o telefone do dono.';
                }
                return null;
              },
              onSaved: (value) => _ownerPhone = value!,
            ),
            const SizedBox(height: 24),
            Text('Detalhes do Pet',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome do Pet'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do pet.';
                }
                return null;
              },
              onSaved: (value) => _petName = value!,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Espécie do Pet'),
              value: _petSpecies,
              items: ['Cachorro', 'Gato', 'Outro']
                  .map((species) => DropdownMenuItem(
                        value: species,
                        child: Text(species),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _petSpecies = value!;
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Raça do Pet'),
              onSaved: (value) => _petBreed = value ?? '',
            ),
            const SizedBox(height: 24),
            Text('Detalhes do Agendamento',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ListTile(
              title: Text(
                  'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text('Hora: ${_selectedTime.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 16),
            Text('Serviços', style: Theme.of(context).textTheme.titleMedium),
            Wrap(
              spacing: 8.0,
              children: _services
                  .map((service) => ChoiceChip(
                        label: Text(service.name),
                        selected: _selectedServices.contains(service),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedServices.add(service);
                            } else {
                              _selectedServices.remove(service);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Observações',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              onSaved: (value) => _observations = value ?? '',
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                ),
                child: const Text('Criar Agendamento'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
