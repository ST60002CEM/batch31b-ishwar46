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
  Future resetState() async {
    state = StaffState.initialState();
    getAllStaff();
  }

  Future<void> getAllStaff() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final staffs = currentState.staffs;
    final hasReachedMax = currentState.hasReachedMax;

    if (!hasReachedMax) {
      try {
        // get data from data source
        final result = await getAllStaffUsecase.getAllStaff(page);
        result.fold(
          (failure) {
            print("Error fetching data: ${failure.error}");
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          },
          (data) {
            if (data.isEmpty) {
              state = state.copyWith(hasReachedMax: true);
            } else {
              state = state.copyWith(
                staffs: [...staffs, ...data],
                page: page,
                isLoading: false,
              );
            }
          },
        );
      } catch (e) {
        print("Unexpected error: $e");
        state = state.copyWith(hasReachedMax: true, isLoading: false);
      }
    }
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
