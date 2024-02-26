import 'package:age_care/features/notifications/domain/entity/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_api_model.g.dart';

@JsonSerializable()
class NotificationApiModel {
  @JsonKey(name: '_id')
  final String notificationId;
  @JsonKey(name: 'recipient')
  final String recipient;
  final String message;
  final bool read;
  final String? createdAt;

  NotificationApiModel({
    required this.notificationId,
    required this.recipient,
    required this.message,
    required this.read,
    this.createdAt,
  });

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationApiModelToJson(this);

  //Convert API Model to domain Entity

  NotificationEntity toEntity() {
    return NotificationEntity(
      notificationId: notificationId,
      recipient: recipient,
      message: message,
      createdAt: createdAt,
      read: read,
    );
  }

  //Create API Model from domain Entity
  factory NotificationApiModel.fromEntity(NotificationEntity entity) {
    return NotificationApiModel(
      notificationId: entity.notificationId,
      recipient: entity.recipient,
      message: entity.message,
      createdAt: entity.createdAt,
      read: entity.read,
    );
  }
}
