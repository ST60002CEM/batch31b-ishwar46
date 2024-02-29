import '../../domain/entity/profile_entity.dart';

class ProfileState {
  final bool isLoading;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? error;
  final String info;
  final List<ProfileEntity>? profile;

  ProfileState(
      {required this.isLoading,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      this.error,
      required this.info,
      this.profile});

  factory ProfileState.initial() {
    return ProfileState(
        isLoading: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        error: null,
        profile: null,
        info: '');
  }

  ProfileState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? error,
    String? info,
    List<ProfileEntity>? profile,
  }) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        error: error ?? this.error,
        info: info ?? this.info,
        profile: profile ?? this.profile);
  }

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, error: $error, info: $info, profile: $profile)';
  }
}
