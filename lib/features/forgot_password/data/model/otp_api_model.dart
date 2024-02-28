import 'package:json_annotation/json_annotation.dart';

part 'otp_api_model.g.dart';

@JsonSerializable()
class OTPApiModel {
  @JsonKey(name: '_id')
  final String? otpId;
  @JsonKey(name: 'userId')
  final String? userId;
  final String? otp;
  final String? createdAt;
  final String? expiryTime;

  OTPApiModel({
    this.otpId,
    this.userId,
    this.otp,
    this.createdAt,
    this.expiryTime,
  });

  factory OTPApiModel.fromJson(Map<String, dynamic> json) =>
      _$OTPApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$OTPApiModelToJson(this);

  @override
  String toString() {
    return 'OTPApiModel(otpId: $otpId, userId: $userId, otp: $otp, createdAt: $createdAt, expiryTime: $expiryTime)';
  }
}
