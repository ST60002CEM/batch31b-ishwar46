import 'package:age_care/features/notifications/domain/entity/notification_entity.dart';
import 'package:age_care/features/notifications/domain/repository/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';

final viewNotificationUseCaseProvider =
    Provider.autoDispose<ViewNotificationUseCase>((ref) =>
        ViewNotificationUseCase(ref.read(notificationRepositoryProvider)));

class ViewNotificationUseCase {
  final INotificationRepository _notificationRepository;

  ViewNotificationUseCase(this._notificationRepository);

  Future<Either<Failure, List<NotificationEntity>>> getNotification() async {
    return await _notificationRepository.getNotifications();
  }
}
