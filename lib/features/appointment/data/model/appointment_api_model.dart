import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/appointment_entity.dart';

part 'appointment_api_model.g.dart';

@JsonSerializable()
class AppointmentApiModel {
  final String serviceType;
  final String serviceDate;
  final String startTime;
  final String endTime;
  final String location;
  final String notes;

  AppointmentApiModel({
    required this.serviceType,
    required this.serviceDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notes,
  });

  factory AppointmentApiModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentApiModelToJson(this);

  // Convert API model to domain entity
  AppointmentEntity toEntity() {
    return AppointmentEntity(
      serviceType: serviceType,
      serviceDate: serviceDate,
      startTime: startTime,
      endTime: endTime,
      location: location,
      notes: notes,
    );
  }

  // Create API model from domain entity
  factory AppointmentApiModel.fromEntity(AppointmentEntity entity) {
    return AppointmentApiModel(
      serviceType: entity.serviceType,
      serviceDate: entity.serviceDate,
      startTime: entity.startTime,
      endTime: entity.endTime,
      location: entity.location,
      notes: entity.notes,
    );
  }
}
