import 'package:age_care/config/router/app_routes.dart';
import 'package:age_care/features/forgot_password/domain/use_cases/send_otp_usecase.dart';
import 'package:age_care/features/forgot_password/domain/use_cases/verify_otp_and_update_password.dart';
import 'package:age_care/features/forgot_password/presentation/state/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpViewModelProvider = StateNotifierProvider<OTPViewModel, OTPState>(
    (ref) => OTPViewModel(ref.read(sendOTPUseCaseProvider),
        ref.read(verifyOTPandUpdateUseCaseProvider)));

class OTPViewModel extends StateNotifier<OTPState> {
  final SendOTPUseCase _sendOTPUseCase;
  final VerifyOTPandUpdatePasswordUseCase _verifyOTPandUpdatePasswordUseCase;

  OTPViewModel(this._sendOTPUseCase, this._verifyOTPandUpdatePasswordUseCase)
      : super(OTPState.initial()) {}

  Future<void> sendOTP(String email, BuildContext context) async {
    EasyLoading.show(status: 'Sending OTP...');
    state = state.copyWith(isLoading: true);
    final result = await _sendOTPUseCase.sendOTP(email);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        if (failure.error == "User not found.") {
          EasyLoading.showError(failure.error);
        } else {
          EasyLoading.showError("Failed to send OTP");
        }
      },
      (success) {
        if (success) {
          EasyLoading.showSuccess('OTP sent to your registered email.');
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamed(context, MyRoutes.verifyOTPRoute);
            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.showError('Failed to send OTP');
        }
      },
    );
  }

  Future<void> verifyOTPandUpdatePassword(String email, String otp,
      String newPassword, BuildContext context) async {
    EasyLoading.show(status: 'Verifying OTP...');
    state = state.copyWith(isLoading: true);
    final result = await _verifyOTPandUpdatePasswordUseCase.verifyandUpdateOTP(
        email, otp, newPassword);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        EasyLoading.showError(failure.error);
      },
      (success) {
        if (success) {
          EasyLoading.showSuccess('Password updated successfully.');
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamed(context, MyRoutes.loginRoute);
            EasyLoading.dismiss();
          });
        } else {
          EasyLoading.showError('Failed to update password');
        }
      },
    );
  }
}
