import 'package:uuid/uuid.dart';

class AppointmentHistory {
  final String id;
  final String houseName;
  final String status;
  final DateTime timestamp;

  AppointmentHistory({
    String? id,
    required this.houseName,
    this.status = 'Chờ xử lý',
    required this.timestamp,
  }) : id = id ?? const Uuid().v4();
}
