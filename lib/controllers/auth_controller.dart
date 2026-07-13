import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  String _phoneNumber = "";
  String _fullName = "";
  bool _isInitialized = false;
  bool _isLoading = false;
  String _errorMessage = "";

  String get phoneNumber => _phoneNumber;
  String get fullName => _fullName;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isLoggedIn => _phoneNumber.isNotEmpty && _fullName.isNotEmpty;

  AuthController() {
    loadAuthData();
  }

  Future<void> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _phoneNumber = prefs.getString('auth_phone_number') ?? "";
    _fullName = prefs.getString('auth_full_name') ?? "";
    _isInitialized = true;
    notifyListeners();
  }

  Future<bool> checkPhoneNumber(String phone) async {
    _isLoading = true;
    _errorMessage = "";
    _phoneNumber = phone;
    notifyListeners();

    final url = Uri.parse('https://6a53d48b8547b9f7111bd6ee.mockapi.io/api/v1/users');

    try {
      final response = await http.get(url);
      _isLoading = false;

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);
        
        final existingUser = users.firstWhere(
          (user) => user['phone_number']?.toString() == phone,
          orElse: () => null,
        );

        if (existingUser != null) {
          _fullName = existingUser['full_name'] ?? "";
          notifyListeners();
          return true;
        }
        notifyListeners();
        return false;
      } else {
        _errorMessage = "Gagal memverifikasi nomor telepon";
        notifyListeners();
        return false;
      }
    } catch (_) {
      _isLoading = false;
      _errorMessage = "Kesalahan jaringan, periksa koneksi Anda";
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerUser(String name) async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    final url = Uri.parse('https://6a53d48b8547b9f7111bd6ee.mockapi.io/api/v1/users');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone_number": _phoneNumber,
          "full_name": name,
        }),
      );

      _isLoading = false;

      if (response.statusCode == 201 || response.statusCode == 200) {
        _fullName = name;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_phone_number', _phoneNumber);
        await prefs.setString('auth_full_name', _fullName);
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Gagal menyimpan pendaftaran pengguna";
        notifyListeners();
        return false;
      }
    } catch (_) {
      _isLoading = false;
      _errorMessage = "Kesalahan jaringan, periksa koneksi Anda";
      notifyListeners();
      return false;
    }
  }

  Future<void> saveExistingUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_phone_number', _phoneNumber);
    await prefs.setString('auth_full_name', _fullName);
    notifyListeners();
  }

  Future<void> clearAuthData() async {
    _phoneNumber = "";
    _fullName = "";
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_phone_number');
    await prefs.remove('auth_full_name');
    notifyListeners();
  }
}