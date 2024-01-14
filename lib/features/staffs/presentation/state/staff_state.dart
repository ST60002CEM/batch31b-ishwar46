import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';

class StaffState {
  final bool isLoading;
  final List<StaffEntity> staffs;
  final bool showMessage;

  StaffState({
    required this.isLoading,
    required this.staffs,
    required this.showMessage,
  });

  factory StaffState.initialState() => StaffState(
        isLoading: false,
        staffs: [],
        showMessage: false,
      );

  StaffState copyWith({
    bool? isLoading,
    List<StaffEntity>? staffs,
    bool? showMessage,
  }) {
    return StaffState(
      isLoading: isLoading ?? this.isLoading,
      staffs: staffs ?? this.staffs,
      showMessage: showMessage ?? this.showMessage,
    );
  }
}
