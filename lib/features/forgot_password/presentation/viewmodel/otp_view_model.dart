import 'package:age_care/config/router/app_routes.dart';
import 'package:age_care/features/forgot_password/domain/use_cases/send_otp_usecase.dart';
import 'package:age_care/features/forgot_password/presentation/state/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpViewModelProvider = StateNotifierProvider<OTPViewModel, OTPState>(
    (ref) => OTPViewModel(ref.read(sendOTPUseCaseProvider)));

class OTPViewModel extends StateNotifier<OTPState> {
  final SendOTPUseCase _sendOTPUseCase;

  OTPViewModel(this._sendOTPUseCase) : super(OTPState.initial()) {
    print(_sendOTPUseCase);
  }

  Future<void> sendOTP(String email, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await _sendOTPUseCase.sendOTP(email);
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
          EasyLoading.showSuccess('OTP sent successfully!');
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
}
