import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';

class AppointmentState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final List<AppointmentEntity>? appointments;

  AppointmentState({
    required this.isLoading,
    this.error,
    this.showMessage,
    this.appointments,
  });

  factory AppointmentState.initial() {
    return AppointmentState(
      isLoading: false,
      error: null,
      showMessage: false,
      appointments: null,
    );
  }

  AppointmentState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<AppointmentEntity>? appointments,
  }) {
    return AppointmentState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      appointments: appointments ?? this.appointments,
    );
  }

  @override
  String toString() => 'AppointmentState(isLoading: $isLoading, error: $error)';
}
