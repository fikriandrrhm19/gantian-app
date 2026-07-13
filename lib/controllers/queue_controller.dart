import 'package:flutter/material.dart';
import '../controllers/merchant_controller.dart';
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

  void updateQueuesFromMerchants(MerchantController merchantController) {
    _isLoading = merchantController.isLoading;
    _errorMessage = merchantController.errorMessage;
    
    List<QueueModel> tempQueues = [];
    for (var merchant in merchantController.merchants) {
      tempQueues.addAll(merchant.queues);
    }
    
    _queues = tempQueues;
    notifyListeners();
  }

  Future<void> fetchQueues() async {
    return;
  }
}