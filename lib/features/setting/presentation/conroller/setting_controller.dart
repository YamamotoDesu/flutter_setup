import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/features/setting/application/setting_service.dart';
import 'package:flutter_setup/features/setting/application/setting_service_impl.dart';
import 'package:flutter_setup/features/setting/presentation/state/setting_state.dart';

final settingConrollerProvider =
    StateNotifierProvider<SettingController, SettingState>((ref) {
  final settingService = ref.watch(settingServiceProvider);
  return SettingController(settingService, const SettingState());
});

class SettingController extends StateNotifier<SettingState> {
  final SettingService _service;

  SettingController(this._service, super.state);

  void addPassCodeToBox(String key, String? value) async {
    final result = await _service.addToBox(key, value);
    if (result) {
      state = state.copyWith(passCode: value);
    }
  }

  void getPassCodeFromBox(String key) async {
    final result = await _service.getFromBox<String>(key);
    state = state.copyWith(passCode: result);
  }
}
