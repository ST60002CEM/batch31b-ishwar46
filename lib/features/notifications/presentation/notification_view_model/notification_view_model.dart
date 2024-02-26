import 'package:age_care/features/notifications/domain/use_case/view_notification_usecase.dart';
import 'package:age_care/features/notifications/presentation/state/notification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationViewModelProvider =
    StateNotifierProvider<NotificationViewModel, NotificationState>(
  (ref) => NotificationViewModel(ref.read(viewNotificationUseCaseProvider)),
);

class NotificationViewModel extends StateNotifier<NotificationState> {
  final ViewNotificationUseCase _viewNotificationUseCase;

  NotificationViewModel(this._viewNotificationUseCase)
      : super(NotificationState.initial()) {
    getNotifications();
  }

  //Get Notifications

  Future<void> getNotifications() async {
    state = state.copyWith(isLoading: true);
    final result = await _viewNotificationUseCase.getNotification();
    state = state.copyWith(isLoading: false);

    result.fold((failure) {
      state = state.copyWith(error: failure.error);
    }, (notifications) {
      state = state.copyWith(notifications: notifications);
    });
  }
}
