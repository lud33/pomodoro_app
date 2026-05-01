import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      
      if (response['token'] != null) {
        await AuthService.saveToken(response['token']);
        _user = User.fromJson(response['user']);
        notifyListeners();
        _isLoading = false;
        return true;
      } else {
        _isLoading = false;
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.register(email, password, name);
      
      if (response['token'] != null) {
        await AuthService.saveToken(response['token']);
        _user = User.fromJson(response['user']);
        notifyListeners();
        _isLoading = false;
        return true;
      } else {
        _isLoading = false;
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await AuthService.clearData();
    _user = null;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}