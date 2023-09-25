import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/local/db/provider/setting_box_provider.dart';
import 'package:flutter_setup/features/setting/data/repository/setting_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

final settingRepositoryProvider = Provider<SettingRepository>((ref) {
  final box = ref.watch(settingBoxProvider);
  return SettingRepositoryImpl(box);
});

class SettingRepositoryImpl implements SettingRepository {
  final Box _box;

  SettingRepositoryImpl(this._box);

  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    await _box.put(key, value);
    return true;
  }

  @override
  Future<T?> getFromBox<T>(String key) async {
    return await _box.get(key);
  }
}
