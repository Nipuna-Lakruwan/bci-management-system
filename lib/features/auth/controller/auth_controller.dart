import 'package:flutter/material.dart';
import '../model/user_session.dart';

class AuthController extends ChangeNotifier {
  UserSession? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserSession? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Hardcoded auth for MVP based on existing logic
    if (email == 'admin' && password == 'admin123') {
      _currentUser = const UserSession(id: 'U1', name: 'Admin User', email: 'admin@bci.lk', role: 'Admin');
    } else if (email == 'hr' && password == 'hr') {
      _currentUser = const UserSession(id: 'U2', name: 'HR Manager', email: 'hr@bci.lk', role: 'HR');
    } else if (email == 'lecturer' && password == 'lecturer') {
      _currentUser = const UserSession(id: 'U3', name: 'Dr. Lecturer', email: 'lecturer@bci.lk', role: 'Lecturer');
    } else {
      _errorMessage = 'Invalid email or password';
      _setLoading(false);
      return false;
    }

    _setLoading(false);
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
