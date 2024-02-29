import 'package:age_care/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:age_care/features/profile/presentation/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>(
        (ref) => ProfileViewModel(ref.read(getProfileUseCaseProvider)));

class ProfileViewModel extends StateNotifier<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileViewModel(this._getProfileUseCase) : super(ProfileState.initial()) {
    getProfile();
  }

  Future<void> getProfile() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await _getProfileUseCase.getProfile();

      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.error),
        (users) => state = state.copyWith(isLoading: false, users: users),
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'An unexpected error occurred');
    }
  }
}
