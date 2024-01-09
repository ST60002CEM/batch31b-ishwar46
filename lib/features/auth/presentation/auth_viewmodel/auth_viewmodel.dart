import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_routes.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/use_case/register_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(registerUseCaseProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUseCase _registerUseCase;

  AuthViewModel(this._registerUseCase) : super(AuthState.initial());

  Future<void> registerStaff(AuthEntity entity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await _registerUseCase.registerStaff(entity);
    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
      },
      (success) {
        if (success) {
          // Show success message using EasyLoading
          EasyLoading.showSuccess('User Registered Successfully',
              dismissOnTap: false);
          // Trigger navigation after delay
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
            // Dismiss EasyLoading after navigation
            EasyLoading.dismiss();
          });
        } else {
          // Handle unexpected registration result
        }
      },
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
    );
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
