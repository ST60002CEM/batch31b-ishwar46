class NotificationEntity {
  final String notificationId;
  final String recipient;
  final String message;
  final String? createdAt;
  final bool read;
  final String createdAtFormatted;

  NotificationEntity({
    required this.notificationId,
    required this.recipient,
    required this.message,
    this.createdAt,
    required this.read,
    required this.createdAtFormatted,
  });

  @override
  List<Object?> get props => [
        notificationId,
        recipient,
        message,
        createdAt,
        read,
        createdAtFormatted,
      ];
}
