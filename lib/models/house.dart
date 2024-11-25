import 'room.dart';

class House {
  final String? id;
  final String name;
  final String contact;
  final String address;
  final String description;
  final List<String> imageUrls;
  final int rent;
  final List<Room> rooms;

  House({
    this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.description,
    required this.imageUrls,
    required this.rent,
    required this.rooms,
  });

  House copyWith({
    String? id,
    String? name,
    String? contact,
    String? address,
    String? description,
    List<String>? imageUrls,
    int? rent,
    List<Room>? rooms,
  }) {
    return House(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      address: address ?? this.address,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      rent: rent ?? this.rent,
      rooms: rooms ?? this.rooms,
    );
  }
}
