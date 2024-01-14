import 'package:age_care/features/staffs/domain/use_case/get_all_usecase.dart';
import 'package:age_care/features/staffs/presentation/state/staff_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final staffViewModelProvider =
    StateNotifierProvider.autoDispose<StaffViewModel, StaffState>(
  (ref) => StaffViewModel(
    getAllStaffUsecase: ref.read(GetAllStaffUsecaseProvider),
  ),
);

class StaffViewModel extends StateNotifier<StaffState> {
  final GetAllStaffUsecase getAllStaffUsecase;

  StaffViewModel({
    required this.getAllStaffUsecase,
  }) : super(StaffState.initialState()) {
    getAllStaff();
  }

  void getAllStaff() {
    state = state.copyWith(isLoading: true);
    getAllStaffUsecase.getAllStaff().then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (staffs) {
          state = state.copyWith(isLoading: false, staffs: staffs);
        },
      );
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
