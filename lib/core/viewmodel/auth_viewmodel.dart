import 'package:flutter/material.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isAuthenticated = false;

  AuthViewModel(this._authRepository);

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    _isAuthenticated = await _authRepository.login(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _isAuthenticated = await _authRepository.register(email, password);
    notifyListeners();
  }
}
