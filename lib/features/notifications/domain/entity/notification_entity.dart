class NotificationEntity {
  final String notificationId;
  final String recipient;
  final String message;
  final DateTime createdAt;
  final bool read;

  NotificationEntity({
    required this.notificationId,
    required this.recipient,
    required this.message,
    required this.createdAt,
    required this.read,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      notificationId: json['_id'],
      recipient: json['recipient'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      read: json['read'],
    );
  }
}
