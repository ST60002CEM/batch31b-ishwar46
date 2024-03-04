import 'package:age_care/features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:age_care/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:age_care/features/profile/presentation/state/profile_state.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/profile_entity.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) =>
        ProfileViewModel(ref.read(getProfileUseCaseProvider),
            ref.read(editProfileUseCaseProvider)));

class ProfileViewModel extends StateNotifier<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;

  ProfileViewModel(this._getProfileUseCase, this._editProfileUseCase)
      : super(ProfileState.initial()) {
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

  //Edit profile
  Future<void> editProfile(ProfileEntity user) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _editProfileUseCase.editProfile(user);

      result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.error),
        (updatedUser) {
          state = state.copyWith(isLoading: false, users: [updatedUser]);
          EasyLoading.showSuccess('Profile updated successfully');
          getProfile();
        },
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'An unexpected error occurred');
    }
  }
}
