class QueueModel {
  final String id;
  final String merchantId;
  final String userNumber;
  final String estimatedCallTime;
  final int peopleAhead;
  final String date;
  final String queueStatus;

  QueueModel({
    required this.id,
    required this.merchantId,
    required this.userNumber,
    required this.estimatedCallTime,
    required this.peopleAhead,
    required this.date,
    required this.queueStatus,
  });

  factory QueueModel.fromJson(Map<String, dynamic> json) {
    return QueueModel(
      id: json['id'] as String,
      merchantId: json['merchant_id'] as String,
      userNumber: json['user_number'] as String,
      estimatedCallTime: json['estimated_call_time'] as String,
      peopleAhead: json['people_ahead'] as int,
      date: json['date'] as String,
      queueStatus: json['queue_status'] as String,
    );
  }
}