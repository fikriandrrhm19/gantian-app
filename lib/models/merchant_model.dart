import 'queue_model.dart';

class MerchantModel {
  final String id;
  final String name;
  final String type;
  final String status;
  final String currentQueue;
  final int waitingUsers;
  final String estimatedTime;
  final double distance;
  final String address;
  final List<QueueModel> queues;

  MerchantModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.currentQueue,
    required this.waitingUsers,
    required this.estimatedTime,
    required this.distance,
    required this.address,
    required this.queues,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    var queueList = json['queues'] as List? ?? [];
    List<QueueModel> parsedQueues = queueList.map((q) => QueueModel.fromJson(q)).toList();

    return MerchantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      currentQueue: json['current_queue'] as String,
      waitingUsers: json['waiting_users'] as int,
      estimatedTime: json['estimated_time'] as String,
      distance: (json['distance'] as num).toDouble(),
      address: json['address'] as String? ?? "Jl. Ir. H. Djuanda, Bandung",
      queues: parsedQueues,
    );
  }
}