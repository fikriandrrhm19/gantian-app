import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  String _phoneNumber = "81234567890";
  String _fullName = "Fikri";

  String get phoneNumber => _phoneNumber;
  String get fullName => _fullName;

  void setPhoneNumber(String number) {
    _phoneNumber = number;
    notifyListeners();
  }

  void setFullName(String name) {
    _fullName = name;
    notifyListeners();
  }

  void clearAuthData() {
    _phoneNumber = "";
    _fullName = "";
    notifyListeners();
  }
}