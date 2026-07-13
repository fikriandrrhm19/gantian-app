import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  String _phoneNumber = "";
  String _fullName = "";
  bool _isInitialized = false;

  String get phoneNumber => _phoneNumber;
  String get fullName => _fullName;
  bool get isInitialized => _isInitialized;
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

  Future<void> saveAuthData({required String name, required String phone}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_phone_number', phone);
    await prefs.setString('auth_full_name', name);
    _phoneNumber = phone;
    _fullName = name;
    notifyListeners();
  }

  Future<void> setPhoneNumber(String number) async {
    _phoneNumber = number;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_phone_number', number);
    notifyListeners();
  }

  Future<void> setFullName(String name) async {
    _fullName = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_full_name', name);
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