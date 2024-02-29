import '../../domain/entity/profile_entity.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final List<ProfileEntity>? users;

  ProfileState(
      {required this.isLoading,
      required this.error,
      required this.showMessage,
      this.users});

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      error: null,
      showMessage: false,
      users: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<ProfileEntity>? users,
  }) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        users: users ?? this.users);
  }

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, error: $error, showMessage: $showMessage, users: $users)';
  }
}
