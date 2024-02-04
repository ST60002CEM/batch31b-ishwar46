import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_routes.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/use_case/login_usecase.dart';
import '../../domain/use_case/register_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
      ref.read(registerUseCaseProvider), ref.read(loginUseCaseProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;

  AuthViewModel(this._registerUseCase, this._loginUseCase)
      : super(AuthState.initial());

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
        } else {}
      },
    );
  }

  //Login Staff

  Future<void> loginStaff(
      String username, String password, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final result = await _loginUseCase.loginStaff(username, password);
    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) {
        state = state.copyWith(
          error: failure.error,
          showMessage: true,
        );
        EasyLoading.showError(failure.error, dismissOnTap: false);
      },
      (success) {
        if (success) {
          EasyLoading.show(
              status: 'Logging in...', maskType: EasyLoadingMaskType.black);
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
            EasyLoading.dismiss();
          });
        } else {
          // Show error message using EasyLoading
          EasyLoading.showError('Invalid username or password',
              dismissOnTap: false);
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
