import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/notifications/data/data_source/notification_remote_data_source.dart';
import 'package:age_care/features/notifications/domain/entity/notification_entity.dart';
import 'package:age_care/features/notifications/domain/repository/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationRemoteRepositoryProvider = Provider<INotificationRepository>(
  (ref) => NotificationRemoteRepository(
      ref.read(notificationRemoteDataSourceProvider)),
);

class NotificationRemoteRepository implements INotificationRepository {
  final NotifcationRemoteDataSource _notifcationRemoteDataSource;

  NotificationRemoteRepository(this._notifcationRemoteDataSource);
  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() {
    return _notifcationRemoteDataSource.getNotifications();
  }
}
