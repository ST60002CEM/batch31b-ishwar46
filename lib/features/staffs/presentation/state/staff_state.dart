import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';

class StaffState {
  final bool isLoading;
  final List<StaffEntity> staffs;
  final bool hasReachedMax;
  final int page;
  final bool showMessage;

  StaffState({
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    required this.staffs,
    required this.showMessage,
  });

  factory StaffState.initialState() => StaffState(
        isLoading: false,
        staffs: [],
        hasReachedMax: false,
        page: 0,
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
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      showMessage: showMessage ?? this.showMessage,
    );
  }
}
