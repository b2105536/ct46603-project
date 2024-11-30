import 'package:flutter/foundation.dart';

import '../../models/house.dart';
import '../../models/room.dart';

class HousesManager with ChangeNotifier {
  final List<House> _houses = [
    House(
      id: 'h1',
      name: 'Nhà trọ Minh Châu',
      contact: '0939123456',
      address: 'Đường 3 Tháng 2, Ninh Kiều, Cần Thơ',
      description: 'Nhà trọ gần trung tâm thành phố, tiện lợi cho sinh viên.',
      imageUrls: [
        'https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2024/11/07/img-4909_1730963512.jpg',
        'https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2024/11/07/img-4911_1730963512.jpg',
      ],
      rent: 1800000,
      rooms: [
        Room(
            number: 1,
            square: 20,
            status: 'Còn trống',
            rentDay: DateTime.now()),
        Room(
            number: 2,
            square: 18,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 10))),
        Room(
            number: 3,
            square: 28,
            status: 'Còn trống',
            rentDay: DateTime.now()),
        Room(
            number: 4,
            square: 20,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 10))),
        Room(
            number: 5,
            square: 30,
            status: 'Còn trống',
            rentDay: DateTime.now()),
        Room(
            number: 6,
            square: 18,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 15))),
        Room(
            number: 7,
            square: 27,
            status: 'Còn trống',
            rentDay: DateTime.now()),
      ],
    ),
    House(
      id: 'h2',
      name: 'Nhà trọ Thanh Bình',
      contact: '0918123456',
      address: 'Đường 30 Tháng 4, Ninh Kiều, Cần Thơ',
      description: 'Nhà trọ rộng rãi, có bãi giữ xe, wifi miễn phí.',
      imageUrls: [
        'https://file4.batdongsan.com.vn/2024/05/06/20240506152745-c1e2_wm.jpg',
        'https://file4.batdongsan.com.vn/2024/05/06/20240506152745-8e72_wm.jpg',
        'https://file4.batdongsan.com.vn/2024/05/06/20240506152744-d5a0_wm.jpg',
      ],
      rent: 1500000,
      rooms: [
        Room(
            number: 1,
            square: 25,
            status: 'Còn trống',
            rentDay: DateTime.now()),
        Room(
            number: 2,
            square: 22,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 5))),
      ],
    ),
    House(
      id: 'h3',
      name: 'Nhà trọ Hồng Phát',
      contact: '0978123456',
      address: 'Phường Hưng Lợi, Ninh Kiều, Cần Thơ',
      description:
          'Nhà trọ an ninh, gần chợ và siêu thị, thích hợp cho sinh viên.',
      imageUrls: [
        'https://file4.batdongsan.com.vn/resize/1275x717/2024/11/19/20241119142732-7730_wm.jpg',
      ],
      rent: 1600000,
      rooms: [
        Room(
            number: 1,
            square: 22,
            status: 'Còn trống',
            rentDay: DateTime.now()),
        Room(
            number: 2,
            square: 20,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 7))),
        Room(
            number: 3,
            square: 25,
            status: 'Còn trống',
            rentDay: DateTime.now()),
      ],
    ),
    House(
      id: 'h4',
      name: 'Nhà trọ Tân An',
      contact: '0939567890',
      address: 'Đường Trần Hưng Đạo, Ninh Kiều, Cần Thơ',
      description: 'Nhà trọ rộng rãi, có ban công và khu vực nấu ăn riêng.',
      imageUrls: [
        'https://file4.batdongsan.com.vn/resize/1275x717/2024/11/25/20241125210437-3603_wm.jpg',
        'https://file4.batdongsan.com.vn/resize/1275x717/2024/11/25/20241125210437-2e8a_wm.jpg',
        'https://file4.batdongsan.com.vn/resize/1275x717/2024/11/25/20241125210437-adca_wm.jpg',
      ],
      rent: 1900000,
      rooms: [
        Room(
            number: 1,
            square: 24,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 3))),
        Room(
            number: 2,
            square: 22,
            status: 'Còn trống',
            rentDay: DateTime.now()),
        Room(
            number: 3,
            square: 20,
            status: 'Đã cho thuê',
            rentDay: DateTime.now().subtract(const Duration(days: 10))),
        Room(
            number: 4,
            square: 26,
            status: 'Còn trống',
            rentDay: DateTime.now()),
      ],
    ),
  ];

  List<House> get houses => [..._houses];

  House? findById(String id) {
    try {
      return _houses.firstWhere((house) => house.id == id);
    } catch (error) {
      return null;
    }
  }

  void updateHouse(House house) {
    final index = _houses.indexWhere((house) => house.id == house.id);
    if (index >= 0) {
      _houses[index] = house;
      notifyListeners();
    }
  }
}
