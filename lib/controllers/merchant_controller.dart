import 'package:flutter/material.dart';
import '../models/merchant_model.dart';

class MerchantController with ChangeNotifier {
  List<MerchantModel> _merchants = [];
  bool _isLoading = false;
  String _errorMessage = "";

  List<MerchantModel> get merchants => _merchants;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchMerchants() async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final List<Map<String, dynamic>> mockData = [
        {
          "id": "1",
          "name": "Barbershop Pak Hendra",
          "type": "Dago",
          "status": "Buka",
          "current_queue": "B-05",
          "waiting_users": 8,
          "estimated_time": "2j 40m",
          "distance": 0.8
        },
        {
          "id": "2",
          "name": "Bengkel Maju Jaya",
          "type": "Antapani",
          "status": "Jeda",
          "current_queue": "C-12",
          "waiting_users": 3,
          "estimated_time": "--",
          "distance": 3.2
        },
        {
          "id": "3",
          "name": "Apotek Sehat Bersama",
          "type": "Buah Batu",
          "status": "Tutup",
          "current_queue": "--",
          "waiting_users": 0,
          "estimated_time": "--",
          "distance": 5.1
        }
      ];

      _merchants = mockData.map((json) => MerchantModel.fromJson(json)).toList();
    } catch (error) {
      _errorMessage = "Terjadi kesalahan memuat data";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}