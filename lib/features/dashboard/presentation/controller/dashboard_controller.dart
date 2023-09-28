import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/features/dashboard/presentation/state/dashboard_state.dart';

final dashboardControllerProvider =
    StateNotifierProvider<DashboardControlleer, DashboardState>((ref) {
  return DashboardControlleer();
});

class DashboardControlleer extends StateNotifier<DashboardState> {
  DashboardControlleer() : super(const DashboardState());

  void setPageIndex(int value) {
    state = state.copyWith(pageIndex: value);
  }
}
