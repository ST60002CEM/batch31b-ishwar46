class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final bool? showMessage;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.showMessage,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    bool? showMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}
