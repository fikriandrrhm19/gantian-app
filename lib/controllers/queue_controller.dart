import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/queue_model.dart';

class QueueController with ChangeNotifier {
  List<QueueModel> _queues = [];
  bool _isLoading = false;
  String _errorMessage = "";

  List<QueueModel> get queues => _queues;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  List<QueueModel> get activeQueues => 
      _queues.where((q) => q.queueStatus.toLowerCase() == 'aktif').toList();

  List<QueueModel> get historyQueues => 
      _queues.where((q) => q.queueStatus.toLowerCase() != 'aktif').toList();

  Future<void> fetchQueues() async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    final url = Uri.parse('https://6a53d48b8547b9f7111bd6ee.mockapi.io/api/v1/queues');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _queues = responseData.map((json) => QueueModel.fromJson(json)).toList();
      } else {
        _errorMessage = "Gagal memuat data antrean";
      }
    } catch (error) {
      _errorMessage = "Terjadi kesalahan jaringan, periksa koneksi Anda";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}