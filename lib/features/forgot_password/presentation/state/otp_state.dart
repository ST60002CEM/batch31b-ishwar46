class OTPState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final bool? showMessage;

  OTPState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.showMessage,
  });

  factory OTPState.initial() {
    return OTPState(
      isLoading: false,
      isSuccess: false,
      error: null,
      showMessage: null,
    );
  }

  OTPState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    bool? showMessage,
  }) {
    return OTPState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OTPState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        other.showMessage == showMessage;
  }
}
