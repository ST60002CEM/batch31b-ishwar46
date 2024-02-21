import 'package:age_care/features/userprofile/domain/use_case/get_user_profile_usecase.dart';
import 'package:age_care/features/userprofile/presentation/state/user_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileViewModelProvider =
    StateNotifierProvider.autoDispose<UserProfileViewModel, UserProfileState>(
        (ref) => UserProfileViewModel(ref.read(GetUserProfileUsecaseProvider),
            userId: 'userId'));

class UserProfileViewModel extends StateNotifier<UserProfileState> {
  final GetUserProfileUsecase getUserProfileUsecase;
  final String userId;

  UserProfileViewModel(this.getUserProfileUsecase, {required this.userId})
      : super(UserProfileState.initialState()) {
    getUserProfile();
  }

  Future getUserProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final result = await getUserProfileUsecase.getUserProfile('userId');
      result.fold(
        (failure) => state =
            state.copyWith(isLoading: false, errorMessage: failure.error),
        (user) => state =
            state.copyWith(isLoading: false, user: user, errorMessage: ''),
      );
    } catch (e) {
      state =
          state.copyWith(isLoading: false, errorMessage: 'An error occurred');
    }
  }
}
