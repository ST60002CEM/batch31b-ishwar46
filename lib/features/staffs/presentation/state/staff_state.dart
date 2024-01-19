import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';

class StaffState {
  final bool isLoading;
  final List<StaffEntity> staffs;
  final bool showMessage;
  final int page;
  final bool hasReachedMax;

  StaffState({
    required this.isLoading,
    required this.staffs,
    required this.showMessage,
    required this.page,
    required this.hasReachedMax,
  });

  factory StaffState.initialState() => StaffState(
        isLoading: false,
        staffs: [],
        showMessage: false,
        page: 0,
        hasReachedMax: false,
      );

  StaffState copyWith({
    bool? isLoading,
    List<StaffEntity>? staffs,
    bool? showMessage,
    int? page,
    bool? hasReachedMax,
  }) {
    return StaffState(
      isLoading: isLoading ?? this.isLoading,
      staffs: staffs ?? this.staffs,
      showMessage: showMessage ?? this.showMessage,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
