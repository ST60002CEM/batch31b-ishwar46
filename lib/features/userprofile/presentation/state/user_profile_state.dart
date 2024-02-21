import 'package:age_care/features/userprofile/domain/entity/user_entity.dart';

class UserProfileState {
  final bool isLoading;
  final List<UserEntity> user;
  final bool showMessage;

  UserProfileState({
    required this.isLoading,
    required this.user,
    required this.showMessage,
  });

  factory UserProfileState.initialState() => UserProfileState(
        isLoading: false,
        user: [],
        showMessage: false,
      );

  UserProfileState copyWith({
    bool? isLoading,
    List<UserEntity>? user,
    bool? showMessage,
    required String errorMessage,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      showMessage: showMessage ?? this.showMessage,
    );
  }
}
