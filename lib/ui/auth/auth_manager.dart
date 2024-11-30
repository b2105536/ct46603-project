import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';

class AuthManager with ChangeNotifier {
  late final AuthService _authService;

  User? _loggedInUser;

  AuthManager() {
    _authService = AuthService(onAuthChange: (User? user) {
      _loggedInUser = user;
      notifyListeners();
    });
  }

  bool get isAuth {
    return _loggedInUser != null;
  }

  User? get user {
    return _loggedInUser;
  }

  set user(User? updatedUser) {
    _loggedInUser = updatedUser;
    notifyListeners();
  }

  Future<User> signup(String mobile, String password, String peradd) {
    return _authService.signup(mobile, password, peradd);
  }

  Future<User> login(String mobile, String password) {
    return _authService.login(mobile, password);
  }

  Future<void> tryAutoLogin() async {
    final user = await _authService.getUserFromStore();
    if (user != null) {
      _loggedInUser = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    return _authService.logout();
  }
}
