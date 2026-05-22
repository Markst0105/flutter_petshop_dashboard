class Booking {
  final String id;
  final String startTime;
  final String endTime;
  final double startHour;
  final double duration;
  final String ownerName;
  final String ownerPhone;
  final String petName;
  final String petType;
  final String petSize;
  final List<String> procedures;
  final BookingStatus status;
  final String comments;

  Booking({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.startHour,
    required this.duration,
    required this.ownerName,
    required this.ownerPhone,
    required this.petName,
    required this.petType,
    required this.petSize,
    required this.procedures,
    required this.status,
    required this.comments,
  });
}

enum BookingStatus { upcoming, inProgress, completed, cancelled }

final todayBookings = [
  Booking(
    id: '1',
    startTime: '09:00',
    endTime: '10:00',
    startHour: 9,
    duration: 1,
    ownerName: 'Ana Silva',
    ownerPhone: '(11) 98765-4321',
    petName: 'Max',
    petType: 'Cachorro',
    petSize: 'Médio',
    procedures: ['Banho', 'Corte de Unhas', 'Tosa'],
    status: BookingStatus.completed,
    comments: 'Pet estava sujo, mas foi limpo com sucesso.',
  ),
  Booking(
    id: '2',
    startTime: '10:30',
    endTime: '11:00',
    startHour: 10.5,
    duration: 0.5,
    ownerName: 'Bruno Santos',
    ownerPhone: '(16) 91234-5678',
    petName: 'Luna',
    petType: 'Gato',
    petSize: 'Pequeno',
    procedures: ['Banho', 'Corte de Unhas'],
    status: BookingStatus.inProgress,
    comments: 'Pet está sendo banhado.',
  ),
  Booking(
    id: '3',
    startTime: '12:00',
    endTime: '13:00',
    startHour: 12,
    duration: 1,
    ownerName: 'Camila Oliveira',
    ownerPhone: '(11) 98877-6655',
    petName: 'Toddy',
    petType: 'Cachorro',
    petSize: 'Grande',
    procedures: ['Tosa Completa', 'Limpeza de Dentes'],
    status: BookingStatus.upcoming,
    comments: 'Pet precisa de tosa completa.',
  ),
  Booking(
    id: '4',
    startTime: '14:00',
    endTime: '14:45',
    startHour: 14,
    duration: 0.75,
    ownerName: 'Daniel Pereira',
    ownerPhone: '(16) 97766-5544',
    petName: 'Bella',
    petType: 'Gato',
    petSize: 'Pequeno',
    procedures: ['Banho', 'Limpeza de Orelhas'],
    status: BookingStatus.upcoming,
    comments: 'Pet precisa de banho e limpeza de orelhas.',
  ),
  Booking(
    id: '5',
    startTime: '15:30',
    endTime: '16:30',
    startHour: 15.5,
    duration: 1,
    ownerName: 'Eduarda Costa',
    ownerPhone: '(11) 96655-4433',
    petName: 'Thor',
    petType: 'Cachorro',
    petSize: 'Grande',
    procedures: ['Tosa', 'Remoção de Subpelo'],
    status: BookingStatus.upcoming,
    comments: 'Pet está ansioso.',
  ),
];
