// import 'package:json_annotation/json_annotation.dart';

// part 'service_api_model.g.dart';

// @JsonSerializable()
// class ServiceApiModel {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String serviceName;

//   ServiceApiModel({
//     this.id,
//     required this.serviceName,
//   });

//   factory ServiceApiModel.fromJson(Map<String, dynamic> json) =>
//       _$ServiceApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ServiceApiModelToJson(this);

//   // Convert API model to domain entity
//   ServiceEntity toEntity() {
//     return ServiceEntity(
//       id: id ?? '',
//       serviceName: serviceName,
//     );
//   }

//   // Create API model from domain entity
//   factory ServiceApiModel.fromEntity(ServiceEntity entity) {
//     return ServiceApiModel(
//       id: entity.id,
//       serviceName: entity.serviceName,
//     );
//   }
// }
