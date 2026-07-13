import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/merchant_model.dart';

class MerchantController with ChangeNotifier {
  List<MerchantModel> _merchants = [];
  bool _isLoading = false;
  String _errorMessage = "";

  List<MerchantModel> get merchants => _merchants;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchMerchants() async {
    if (_merchants.isEmpty) {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();
    }

    final url = Uri.parse('https://6a53d48b8547b9f7111bd6ee.mockapi.io/api/v1/merchants');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _merchants = responseData.map((json) => MerchantModel.fromJson(json)).toList();
        _errorMessage = "";
      } else {
        _errorMessage = "Gagal mengambil data dari server";
      }
    } catch (error) {
      if (_merchants.isEmpty) {
        _errorMessage = "Terjadi kesalahan jaringan, silakan coba lagi";
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}