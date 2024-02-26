import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/appointment_entity.dart';

part 'appointment_api_model.g.dart';

@JsonSerializable()
class AppointmentApiModel {
  @JsonKey(name: '_id')
  final String? appointmentId;
  final String serviceType;
  final String serviceDate;
  final String startTime;
  final String endTime;
  final String location;
  final String notes;
  final String? ticketNumber;
  final String? status;

  AppointmentApiModel({
    this.appointmentId,
    required this.serviceType,
    required this.serviceDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.notes,
    this.ticketNumber,
    this.status,
  });

  factory AppointmentApiModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentApiModelToJson(this);

  // Convert API model to domain entity
  AppointmentEntity toEntity() {
    return AppointmentEntity(
      appointmentId: appointmentId,
      serviceType: serviceType,
      serviceDate: serviceDate,
      startTime: startTime,
      endTime: endTime,
      location: location,
      notes: notes,
      ticketNumber: ticketNumber,
      status: status,
    );
  }

  // Create API model from domain entity
  factory AppointmentApiModel.fromEntity(AppointmentEntity entity) {
    return AppointmentApiModel(
      appointmentId: entity.appointmentId,
      serviceType: entity.serviceType,
      serviceDate: entity.serviceDate,
      startTime: entity.startTime,
      endTime: entity.endTime,
      location: entity.location,
      notes: entity.notes,
      ticketNumber: entity.ticketNumber,
      status: entity.status,
    );
  }
}
