import 'package:age_care/features/appointment/data/model/appointment_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_appointments_dto.g.dart';

@JsonSerializable()
class GetAppointmentsDTO {
  final bool success;
  @JsonKey(name: 'appointments')
  final List<AppointmentApiModel> data;

  GetAppointmentsDTO({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAppointmentsDTOToJson(this);

  factory GetAppointmentsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAppointmentsDTOFromJson(json);
}
