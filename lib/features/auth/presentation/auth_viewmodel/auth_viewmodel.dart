import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/auth_entity.dart';
import '../../domain/use_case/register_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(registerUseCaseProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUseCase _registerUseCase;

  AuthViewModel(this._registerUseCase) : super(AuthState.initial());

  Future<void> registerStaff(AuthEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _registerUseCase.registerStaff(entity);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (success) => state = state.copyWith(isLoading: false, showMessage: true),
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
