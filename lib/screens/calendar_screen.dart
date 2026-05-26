import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class DayBooking {
  final String id;
  final String time;
  final String duration;
  final String description;
  final String petName;
  final String petType;
  final String ownerName;
  final String ownerPhone;
  final String petSize;

  DayBooking({
    required this.id,
    required this.time,
    required this.duration,
    required this.description,
    required this.petName,
    required this.petType,
    required this.ownerName,
    required this.ownerPhone,
    required this.petSize,
  });
}

// Mock data for day bookings
final dayBookings = {
  '2025-10-29': [
    DayBooking(
      id: '1',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Max',
      petType: 'Cachorro',
      ownerName: 'João Silva',
      ownerPhone: '11 98765-4321',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '2',
      time: '10:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Bella',
      petType: 'Gato',
      ownerName: 'Maria Oliveira',
      ownerPhone: '11 97654-3210',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '3',
      time: '11:30 AM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Charlie',
      petType: 'Cachorro',
      ownerName: 'Pedro Santos',
      ownerPhone: '11 96543-2109',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '4',
      time: '02:00 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Luna',
      petType: 'Gato',
      ownerName: 'Ana Pereira',
      ownerPhone: '11 95432-1098',
      petSize: 'Pequeno',
    ),
  ],
  '2025-10-30': [
    DayBooking(
      id: '5',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Rocky',
      petType: 'Cachorro',
      ownerName: 'Carlos Silva',
      ownerPhone: '11 94321-0987',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '6',
      time: '02:00 PM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Whiskers',
      petType: 'Gato',
      ownerName: 'Lucia Costa',
      ownerPhone: '11 93210-9876',
      petSize: 'Pequeno',
    ),
  ],
  '2025-10-31': [
    DayBooking(
      id: '16',
      time: '10:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Mimi',
      petType: 'Gato',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 94321-0987',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-01': [
    DayBooking(
      id: '7',
      time: '10:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Duke',
      petType: 'Cachorro',
      ownerName: 'Maria Santos',
      ownerPhone: '11 92109-8765',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '8',
      time: '02:00 PM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Garfield',
      petType: 'Gato',
      ownerName: 'João Costa',
      ownerPhone: '11 91098-7654',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '9',
      time: '04:00 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Buddy',
      petType: 'Cachorro',
      ownerName: 'Ana Silva',
      ownerPhone: '11 90987-6543',
      petSize: 'Grande',
    ),
  ],
  '2025-11-03': [
    DayBooking(
      id: '17',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Oscar',
      petType: 'Cachorro',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 93210-9876',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '18',
      time: '11:00 AM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Mingau',
      petType: 'Gato',
      ownerName: 'Rafael Costa',
      ownerPhone: '11 92109-8765',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '19',
      time: '02:00 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Zeus',
      petType: 'Cachorro',
      ownerName: 'Camila Ferreira',
      ownerPhone: '11 91098-7654',
      petSize: 'Grande',
    ),
  ],
  '2025-11-04': [
    DayBooking(
      id: '10',
      time: '11:00 AM',
      duration: '1 hora',
      description: 'Banho',
      petName: 'Poodle',
      petType: 'Cachorro',
      ownerName: 'Patricia Alves',
      ownerPhone: '11 89876-5432',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-05': [
    DayBooking(
      id: '5',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Thor',
      petType: 'Cachorro',
      ownerName: 'Lucas Mendonça',
      ownerPhone: '11 90987-6543',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '6',
      time: '10:30 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Frajola',
      petType: 'Gato',
      ownerName: 'Juliana Alves',
      ownerPhone: '11 89876-5432',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '7',
      time: '11:30 AM',
      duration: '1.5 horas',
      description: 'Pacote Completo',
      petName: 'Fred',
      petType: 'Cachorro',
      ownerName: 'Rafaela Gomes',
      ownerPhone: '11 88765-4321',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '8',
      time: '02:00 PM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Nino',
      petType: 'Gato',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 87654-3210',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '9',
      time: '03:30 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Rex',
      petType: 'Cachorro',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 86543-2109',
      petSize: 'Médio',
    ),
  ],
  '2025-11-06': [
    DayBooking(
      id: '11',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Spike',
      petType: 'Cachorro',
      ownerName: 'Roberto Lima',
      ownerPhone: '11 88765-4321',
      petSize: 'Grande',
    ),
  ],
  '2025-11-07': [
    DayBooking(
      id: '12',
      time: '10:00 AM',
      duration: '45 minutos',
      description: 'Banho',
      petName: 'Kitty',
      petType: 'Gato',
      ownerName: 'Beatriz Gomes',
      ownerPhone: '11 87654-3210',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '13',
      time: '02:00 PM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Leo',
      petType: 'Cachorro',
      ownerName: 'Fernando Dias',
      ownerPhone: '11 86543-2109',
      petSize: 'Médio',
    ),
  ],
  '2025-11-08': [
    DayBooking(
      id: '20',
      time: '09:30 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Mel',
      petType: 'Cachorro',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 85432-1098',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '21',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Limpeza de Orelhas',
      petName: 'Oliver',
      petType: 'Gato',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 84321-0987',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '22',
      time: '01:30 PM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Bob',
      petType: 'Cachorro',
      ownerName: 'Rafael Costa',
      ownerPhone: '11 83210-9876',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '23',
      time: '03:00 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Milo',
      petType: 'Gato',
      ownerName: 'Camila Ferreira',
      ownerPhone: '11 82109-8765',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-10': [
    DayBooking(
      id: '14',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Rusty',
      petType: 'Cachorro',
      ownerName: 'Gustavo Silva',
      ownerPhone: '11 85432-1098',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '15',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Limpeza',
      petName: 'Miau',
      petType: 'Gato',
      ownerName: 'Larissa Martins',
      ownerPhone: '11 84321-0987',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '16',
      time: '02:00 PM',
      duration: '1 hora',
      description: 'Banho',
      petName: 'Scout',
      petType: 'Cachorro',
      ownerName: 'Heitor Rocha',
      ownerPhone: '11 83210-9876',
      petSize: 'Médio',
    ),
  ],
  '2025-11-12': [
    DayBooking(
      id: '24',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Serviço Completo',
      petName: 'Nina',
      petType: 'Cachorro',
      ownerName: 'Lucas Mendonça',
      ownerPhone: '11 81098-7654',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '25',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Simba',
      petType: 'Gato',
      ownerName: 'Juliana Alves',
      ownerPhone: '11 80987-6543',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '26',
      time: '03:00 PM',
      duration: '45 minutos',
      description: 'Banho',
      petName: 'Teddy',
      petType: 'Cachorro',
      ownerName: 'Rafaela Gomes',
      ownerPhone: '11 79876-5432',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '27',
      time: '04:30 PM',
      duration: '1 hora',
      description: 'Limpeza de Dentes',
      petName: 'Mittens',
      petType: 'Gato',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 78765-4321',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-14': [
    DayBooking(
      id: '24',
      time: '10:00 AM',
      duration: '1 hora',
      description: 'Serviço Completo',
      petName: 'Nina',
      petType: 'Cachorro',
      ownerName: 'Lucas Mendonça',
      ownerPhone: '11 81098-7654',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '25',
      time: '02:00 PM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Simba',
      petType: 'Gato',
      ownerName: 'Juliana Alves',
      ownerPhone: '11 80987-6543',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '26',
      time: '03:30 PM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Teddy',
      petType: 'Cachorro',
      ownerName: 'Rafaela Gomes',
      ownerPhone: '11 79876-5432',
      petSize: 'Grande',
    ),
  ],
  '2025-11-18': [
    DayBooking(
      id: '27',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Lola',
      petType: 'Cachorro',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 78765-4321',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '28',
      time: '10:30 AM',
      duration: '30 minutos',
      description: 'Limpeza de Orelhas',
      petName: 'Nala',
      petType: 'Gato',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 77654-3210',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '29',
      time: '12:00 PM',
      duration: '1.5 horas',
      description: 'Pacote Completo',
      petName: 'Urso',
      petType: 'Cachorro',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 76543-2109',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '30',
      time: '02:30 PM',
      duration: '45 minutos',
      description: 'Banho e Tosa',
      petName: 'Luna',
      petType: 'Gato',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 75432-1098',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '31',
      time: '04:00 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Marley',
      petType: 'Cachorro',
      ownerName: 'Rafael Costa',
      ownerPhone: '11 74321-0987',
      petSize: 'Médio',
    ),
  ],
  '2025-11-21': [
    DayBooking(
      id: '32',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Belinha',
      petType: 'Cachorro',
      ownerName: 'Camila Ferreira',
      ownerPhone: '11 73210-9876',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '33',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Gizmo',
      petType: 'Gato',
      ownerName: 'Lucas Mendonça',
      ownerPhone: '11 72109-8765',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '34',
      time: '01:00 PM',
      duration: '1 hora',
      description: 'Banho e Escovação',
      petName: 'Murphy',
      petType: 'Cachorro',
      ownerName: 'Juliana Alves',
      ownerPhone: '11 71098-7654',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '35',
      time: '03:00 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Oreo',
      petType: 'Gato',
      ownerName: 'Rafaela Gomes',
      ownerPhone: '11 70987-6543',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-24': [
    DayBooking(
      id: '36',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Coco',
      petType: 'Cachorro',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 69876-5432',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '37',
      time: '10:30 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Pretinho',
      petType: 'Gato',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 68765-4321',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '38',
      time: '01:00 PM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Meg',
      petType: 'Cachorro',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 67654-3210',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '39',
      time: '02:30 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Felix',
      petType: 'Gato',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 66543-2109',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '40',
      time: '04:00 PM',
      duration: '1 hora',
      description: 'Serviço Completo',
      petName: 'Bailey',
      petType: 'Cachorro',
      ownerName: 'Rafael Costa',
      ownerPhone: '11 65432-1098',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '41',
      time: '05:30 PM',
      duration: '30 minutos',
      description: 'Limpeza de Orelhas',
      petName: 'Tigrão',
      petType: 'Gato',
      ownerName: 'Camila Ferreira',
      ownerPhone: '11 64321-0987',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-25': [
    DayBooking(
      id: '10',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Coco',
      petType: 'Cachorro',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 69876-5432',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '11',
      time: '10:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Pretinho',
      petType: 'Gato',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 68765-4321',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '12',
      time: '11:00 AM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Meg',
      petType: 'Cachorro',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 67654-3210',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '13',
      time: '01:00 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Felix',
      petType: 'Gato',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 66543-2109',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '14',
      time: '02:30 PM',
      duration: '1 hora',
      description: 'Serviço Completo',
      petName: 'Bailey',
      petType: 'Cachorro',
      ownerName: 'Rafael Costa',
      ownerPhone: '11 65432-1098',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '15',
      time: '04:00 PM',
      duration: '30 minutos',
      description: 'Limpeza de Orelhas',
      petName: 'Tigrão',
      petType: 'Gato',
      ownerName: 'Camila Ferreira',
      ownerPhone: '11 64321-0987',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-26': [
    DayBooking(
      id: '42',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Pascal',
      petType: 'Cachorro',
      ownerName: 'Gustavo Santos',
      ownerPhone: '11 63210-9876',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '43',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Tom',
      petType: 'Gato',
      ownerName: 'Beatriz Lima',
      ownerPhone: '11 62109-8765',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '44',
      time: '02:00 PM',
      duration: '1 hora',
      description: 'Banho',
      petName: 'Spike',
      petType: 'Cachorro',
      ownerName: 'Henrique Costa',
      ownerPhone: '11 61098-7654',
      petSize: 'Grande',
    ),
  ],
  '2025-11-27': [
    DayBooking(
      id: '45',
      time: '10:00 AM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Bruno',
      petType: 'Cachorro',
      ownerName: 'Mariana Oliveira',
      ownerPhone: '11 60987-6543',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '46',
      time: '02:00 PM',
      duration: '30 minutos',
      description: 'Limpeza',
      petName: 'Felicia',
      petType: 'Gato',
      ownerName: 'Larissa Dias',
      ownerPhone: '11 59876-5432',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-28': [
    DayBooking(
      id: '47',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Kaiser',
      petType: 'Cachorro',
      ownerName: 'Felipe Gomes',
      ownerPhone: '11 58765-4321',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '48',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Duchess',
      petType: 'Gato',
      ownerName: 'Priscila Martins',
      ownerPhone: '11 57654-3210',
      petSize: 'Pequeno',
    ),
  ],
  '2025-11-29': [
    DayBooking(
      id: '49',
      time: '10:00 AM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Shadow',
      petType: 'Cachorro',
      ownerName: 'Diego Rocha',
      ownerPhone: '11 56543-2109',
      petSize: 'Médio',
    ),
  ],
  '2025-12-02': [
    DayBooking(
      id: '36',
      time: '10:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Jasper',
      petType: 'Cachorro',
      ownerName: 'Lucas Mendonça',
      ownerPhone: '11 63210-9876',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '37',
      time: '12:00 PM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Fofinho',
      petType: 'Gato',
      ownerName: 'Juliana Alves',
      ownerPhone: '11 62109-8765',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '38',
      time: '02:00 PM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Hank',
      petType: 'Cachorro',
      ownerName: 'Rafaela Gomes',
      ownerPhone: '11 61098-7654',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '39',
      time: '03:30 PM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Nino',
      petType: 'Gato',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 60987-6543',
      petSize: 'Pequeno',
    ),
  ],
  '2025-12-05': [
    DayBooking(
      id: '50',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Ace',
      petType: 'Cachorro',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 59876-5432',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '51',
      time: '10:30 AM',
      duration: '30 minutos',
      description: 'Limpeza de Orelhas',
      petName: 'Pintado',
      petType: 'Gato',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 58765-4321',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '52',
      time: '12:00 PM',
      duration: '1.5 horas',
      description: 'Pacote Completo',
      petName: 'Jake',
      petType: 'Cachorro',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 57654-3210',
      petSize: 'Grande',
    ),
  ],
  '2025-12-09': [
    DayBooking(
      id: '40',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Ace',
      petType: 'Cachorro',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 59876-5432',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '41',
      time: '10:30 AM',
      duration: '30 minutos',
      description: 'Limpeza de Orelhas',
      petName: 'Pintado',
      petType: 'Gato',
      ownerName: 'Carlos Pereira',
      ownerPhone: '11 58765-4321',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '42',
      time: '12:00 PM',
      duration: '1.5 horas',
      description: 'Pacote Completo',
      petName: 'Jake',
      petType: 'Cachorro',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 57654-3210',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '43',
      time: '02:30 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Zoe',
      petType: 'Cachorro',
      ownerName: 'Rafael Costa',
      ownerPhone: '11 56543-2109',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '44',
      time: '04:00 PM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Pipoca',
      petType: 'Gato',
      ownerName: 'Camila Ferreira',
      ownerPhone: '11 55432-1098',
      petSize: 'Pequeno',
    ),
  ],
  '2025-12-10': [
    DayBooking(
      id: '53',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Banho',
      petName: 'Pax',
      petType: 'Cachorro',
      ownerName: 'Monica Silva',
      ownerPhone: '11 54321-0987',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '54',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Limpeza',
      petName: 'Smoky',
      petType: 'Gato',
      ownerName: 'Rodrigo Alves',
      ownerPhone: '11 53210-9876',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '55',
      time: '02:00 PM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Daisy',
      petType: 'Cachorro',
      ownerName: 'Tatiana Lima',
      ownerPhone: '11 52109-8765',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '56',
      time: '03:30 PM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Molly',
      petType: 'Gato',
      ownerName: 'Sergio Costa',
      ownerPhone: '11 51098-7654',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '57',
      time: '05:00 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Rex',
      petType: 'Cachorro',
      ownerName: 'Adriana Gomes',
      ownerPhone: '11 50987-6543',
      petSize: 'Médio',
    ),
  ],
  '2025-12-18': [
    DayBooking(
      id: '45',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Winston',
      petType: 'Cachorro',
      ownerName: 'Lucas Mendonça',
      ownerPhone: '11 54321-0987',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '46',
      time: '10:30 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Tom',
      petType: 'Gato',
      ownerName: 'Juliana Alves',
      ownerPhone: '11 53210-9876',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '47',
      time: '12:00 PM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Roxy',
      petType: 'Cachorro',
      ownerName: 'Rafaela Gomes',
      ownerPhone: '11 52109-8765',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '48',
      time: '02:00 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Pepper',
      petType: 'Gato',
      ownerName: 'Vinicius Souza',
      ownerPhone: '11 51098-7654',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '49',
      time: '03:30 PM',
      duration: '1 hora',
      description: 'Serviço Completo',
      petName: 'Brutus',
      petType: 'Cachorro',
      ownerName: 'Isabela Costa',
      ownerPhone: '11 50987-6543',
      petSize: 'Médio',
    ),
  ],
  '2025-12-20': [
    DayBooking(
      id: '58',
      time: '10:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Storm',
      petType: 'Cachorro',
      ownerName: 'Amanda Oliveira',
      ownerPhone: '11 49876-5432',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '59',
      time: '02:00 PM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Kiki',
      petType: 'Gato',
      ownerName: 'Lucas Dias',
      ownerPhone: '11 48765-4321',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '60',
      time: '03:30 PM',
      duration: '1 hora',
      description: 'Banho',
      petName: 'Hunter',
      petType: 'Cachorro',
      ownerName: 'Patricia Rocha',
      ownerPhone: '11 47654-3210',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '61',
      time: '05:00 PM',
      duration: '45 minutos',
      description: 'Banho e Escovação',
      petName: 'Pussycat',
      petType: 'Gato',
      ownerName: 'Roberto Ferreira',
      ownerPhone: '11 46543-2109',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '62',
      time: '06:30 PM',
      duration: '1 hora',
      description: 'Tosa',
      petName: 'Buddy',
      petType: 'Cachorro',
      ownerName: 'Fernanda Souza',
      ownerPhone: '11 45432-1098',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '63',
      time: '08:00 PM',
      duration: '30 minutos',
      description: 'Limpeza',
      petName: 'Tigre',
      petType: 'Gato',
      ownerName: 'Heitor Lima',
      ownerPhone: '11 44321-0987',
      petSize: 'Pequeno',
    ),
  ],
  '2025-12-23': [
    DayBooking(
      id: '64',
      time: '09:00 AM',
      duration: '1 hora',
      description: 'Tosa Completa',
      petName: 'Phoenix',
      petType: 'Cachorro',
      ownerName: 'Vanessa Costa',
      ownerPhone: '11 43210-9876',
      petSize: 'Grande',
    ),
    DayBooking(
      id: '65',
      time: '11:00 AM',
      duration: '30 minutos',
      description: 'Corte de Unhas',
      petName: 'Shadow',
      petType: 'Gato',
      ownerName: 'Gustavo Dias',
      ownerPhone: '11 42109-8765',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '66',
      time: '01:00 PM',
      duration: '1 hora',
      description: 'Banho e Tosa',
      petName: 'Sarge',
      petType: 'Cachorro',
      ownerName: 'Mariano Lima',
      ownerPhone: '11 41098-7654',
      petSize: 'Médio',
    ),
    DayBooking(
      id: '67',
      time: '02:30 PM',
      duration: '45 minutos',
      description: 'Limpeza de Dentes',
      petName: 'Princess',
      petType: 'Gato',
      ownerName: 'Raquel Gomes',
      ownerPhone: '11 40987-6543',
      petSize: 'Pequeno',
    ),
    DayBooking(
      id: '68',
      time: '04:00 PM',
      duration: '1 hora',
      description: 'Serviço Completo',
      petName: 'Tank',
      petType: 'Cachorro',
      ownerName: 'Thiago Silva',
      ownerPhone: '11 39876-5432',
      petSize: 'Grande',
    ),
  ],
};

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  String? _expandedBookingId;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final firstDay = DateTime(2025, 1, 1);
    final lastDay = DateTime(2025, 12, 31);
    _focusedDay =
        now.isAfter(firstDay) && now.isBefore(lastDay) ? now : firstDay;
    _selectedDay = _focusedDay;
  }

  Color _getDensityColor(int density) {
    if (density == 0) return Colors.transparent;
    if (density <= 2) return Colors.yellow.shade200;
    if (density <= 4) return Colors.orange.shade300;
    return Colors.red.shade400;
  }

  Color _getDensityHoverColor(int density) {
    if (density == 0) return Colors.transparent;
    if (density <= 2) return Colors.yellow.shade300;
    if (density <= 4) return Colors.orange.shade400;
    return Colors.red.shade500;
  }

  List<DayBooking> _getBookingsForDate(DateTime date) {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return dayBookings[dateStr] ?? [];
  }

  int _getBookingCount(DateTime date) {
    return _getBookingsForDate(date).length;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final bookingsForSelectedDay = _getBookingsForDate(_selectedDay);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: isMobile
            ? _buildMobileLayout(bookingsForSelectedDay)
            : _buildDesktopLayout(bookingsForSelectedDay),
      ),
    );
  }

  Widget _buildMobileLayout(List<DayBooking> bookings) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 400),
            child: _buildCalendarCard(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 400,
            child: _buildBookingsCard(bookings),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(List<DayBooking> bookings) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildCalendarCard(),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 800,
            child: _buildBookingsCard(bookings),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Calendário mensal',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dias são coloridos baseados na desidade de agendamentos: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDensityLegendItem(
                      Colors.yellow.shade200, 'Baixo (1-2)'),
                  const SizedBox(width: 16),
                  _buildDensityLegendItem(
                      Colors.orange.shade300, 'Médio (3-4)'),
                  const SizedBox(width: 16),
                  _buildDensityLegendItem(Colors.red.shade400, 'Alto (5+)'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TableCalendar(
              firstDay: DateTime(2025, 1, 1),
              lastDay: DateTime(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _expandedBookingId = null;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final count = _getBookingCount(day);
                  return Container(
                    decoration: BoxDecoration(
                      color: _getDensityColor(count),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: count > 4 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final count = _getBookingCount(day);
                  return Container(
                    decoration: BoxDecoration(
                      color: _getDensityColor(count),
                      border: Border.all(
                        color: Colors.blue.shade500,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: count > 4 ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final count = _getBookingCount(day);
                  return Container(
                    decoration: BoxDecoration(
                      color: _getDensityColor(count),
                      border: Border.all(
                        color: Colors.blue.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: count > 4 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
              calendarStyle: const CalendarStyle(
                cellMargin: EdgeInsets.all(6),
                outsideDaysVisible: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDensityLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildBookingsCard(List<DayBooking> bookings) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agendamentos para ${_selectedDay.day} de ${_getMonthName(_selectedDay.month)} de ${_selectedDay.year}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: bookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 48,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum agendamento',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      final isExpanded = _expandedBookingId == booking.id;
                      return _buildBookingCard(booking, isExpanded);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(DayBooking booking, bool isExpanded) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              if (_expandedBookingId == booking.id) {
                _expandedBookingId = null;
              } else {
                _expandedBookingId = booking.id;
              }
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade50,
                  Colors.green.shade50,
                ],
              ),
              border: Border.all(color: Colors.blue.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${booking.petName} - ${booking.petType}',
                            style: Theme.of(context).textTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  booking.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      booking.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Duração: ${booking.duration}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 12),
                  Divider(
                    height: 12,
                    color: Colors.blue.shade200,
                  ),
                  const SizedBox(height: 8),
                  _buildOwnerInfo(booking),
                  const SizedBox(height: 12),
                  _buildPetInfo(booking),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOwnerInfo(DayBooking booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person,
              size: 14,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              'Dono',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.ownerName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    booking.ownerPhone,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle call action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ligando para ${booking.ownerPhone}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.phone, size: 14),
                    label: const Text('Ligar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetInfo(DayBooking booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.pets,
              size: 14,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              'Pet',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            'Tamanho: ${booking.petSize}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];
    return months[month - 1];
  }
}
