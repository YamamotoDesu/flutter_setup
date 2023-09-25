import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/features/setting/application/setting_service.dart';
import 'package:flutter_setup/features/setting/data/repository/setting_repository.dart';
import 'package:flutter_setup/features/setting/data/repository/setting_repository_impl.dart';

final settingServiceProvider = Provider<SettingService>((ref) {
  final repository = ref.watch(settingRepositoryProvider);
  return SettingServiceImpl(repository);
});

class SettingServiceImpl implements SettingService {
  SettingServiceImpl(this._repository);

  final SettingRepository _repository;

  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    final result = await _repository.addToBox<T>(key, value);
    return result;
  }

  @override
  Future<T?> getFromBox<T>(String key) async {
    return await _repository.getFromBox<T>(key);
  }
}
