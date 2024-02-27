import 'package:age_care/features/notifications/domain/entity/notification_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/notification_remote_repo_impl.dart';

final notificationRepositoryProvider = Provider<INotificationRepository>(
  (ref) => ref.read(notificationRemoteRepositoryProvider),
);

abstract class INotificationRepository {
  //Get Notifications
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
}
