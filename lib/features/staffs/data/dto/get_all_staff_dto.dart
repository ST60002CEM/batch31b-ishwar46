import 'package:json_annotation/json_annotation.dart';

import '../model/staff_api_model.dart';

part 'get_all_staff_dto.g.dart';

@JsonSerializable()
class GetAllStaffDTO {
  final bool success;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'users')
  final List<StaffAPIModel> data;

  GetAllStaffDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllStaffDTOToJson(this);

  factory GetAllStaffDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllStaffDTOFromJson(json);
}
