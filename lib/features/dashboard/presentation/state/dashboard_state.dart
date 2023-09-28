import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed // 16.54
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(0) int pageIndex,
  }) = _DashboardState;
}
