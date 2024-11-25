class Room {
  final String? id;
  final int number;
  final double square;
  final String status;
  final DateTime rentDay;

  Room({
    this.id,
    required this.number,
    required this.square,
    required this.status,
    DateTime? rentDay,
  }) : rentDay = rentDay ?? DateTime.now();

  Room copyWith({
    String? id,
    int? number,
    double? square,
    String? status,
    DateTime? rentDay,
  }) {
    return Room(
      id: id ?? this.id,
      number: number ?? this.number,
      square: square ?? this.square,
      status: status ?? this.status,
      rentDay: rentDay ?? this.rentDay,
    );
  }
}
