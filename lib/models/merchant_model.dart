class MerchantModel {
  final String id;
  final String name;
  final String type;
  final String status;
  final String currentQueue;
  final int waitingUsers;
  final String estimatedTime;
  final double distance;

  MerchantModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.currentQueue,
    required this.waitingUsers,
    required this.estimatedTime,
    required this.distance,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      currentQueue: json['current_queue'] as String,
      waitingUsers: json['waiting_users'] as int,
      estimatedTime: json['estimated_time'] as String,
      distance: (json['distance'] as num).toDouble(),
    );
  }
}