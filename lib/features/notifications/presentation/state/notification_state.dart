import 'package:age_care/features/notifications/domain/entity/notification_entity.dart';

class NotificationState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final List<NotificationEntity>? notifications;

  NotificationState({
    required this.isLoading,
    required this.error,
    required this.showMessage,
    required this.notifications,
  });

  factory NotificationState.initial() {
    return NotificationState(
      isLoading: false,
      error: null,
      showMessage: false,
      notifications: null,
    );
  }

  NotificationState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<NotificationEntity>? notifications,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  String toString() =>
      'NotificationState(isLoading: $isLoading, error: $error)';
}
