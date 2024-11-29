import 'package:flutter/foundation.dart';

import '../../models/user.dart';

class UsersManager with ChangeNotifier {
  final List<User> _users = [
    User(
      id: 'u1',
      name: 'Nguyen Van A',
      mobile: '0123456789',
      peradd: 'TP.HCM',
      temadd: '',
      avatar: '',
      gender: true,
      dob: DateTime(1990, 5, 1),
      role: false,
    ),
    User(
      id: 'u2',
      name: 'Tran Thi B',
      mobile: '0987654321',
      peradd: 'Can Tho',
      avatar: '',
      gender: false,
      dob: DateTime(1995, 8, 15),
      role: true,
    ),
  ];

  List<User> get users => [..._users];

  User getUserByPhoneNumber(String mobile) {
    return _users.firstWhere((user) => user.mobile == mobile,
        orElse: () =>
            throw Exception('Không tìm thấy người dùng với số điện thoại này'));
  }

  void updateUser(String id, User updatedUser) {
    final index = _users.indexWhere((u) => u.id == id);
    if (index != -1) {
      _users[index] = updatedUser;
      notifyListeners();
    }
  }
}
