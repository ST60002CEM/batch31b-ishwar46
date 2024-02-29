import 'package:age_care/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:age_care/features/profile/presentation/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>(
        (ref) => ProfileViewModel(ref.read(getProfileUseCaseProvider)));

class ProfileViewModel extends StateNotifier<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileViewModel(this._getProfileUseCase) : super(ProfileState.initial());

  Future<void> getProfile(String userId) async {
    state = state.copyWith(isLoading: true, error: '');

    try {
      final result = await _getProfileUseCase.getProfile(userId);

      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.error),
        (profileList) =>
            state = state.copyWith(isLoading: false, profile: profileList),
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'An unexpected error occurred');
    }
  }
}
