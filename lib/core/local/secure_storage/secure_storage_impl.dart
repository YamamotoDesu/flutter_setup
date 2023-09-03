import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_setup/core/local/secure_storage/flutter_secure_storage_provider.dart';
import 'package:flutter_setup/core/local/secure_storage/secure_storage_const.dart';
import 'package:flutter_setup/core/local/secure_storage/seucre_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  final flutterSecureStorage = ref.watch(flutterSecureStorageProvider);
  return SecureStorageImpl(flutterSecureStorage);
});

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage;

  SecureStorageImpl(this._flutterSecureStorage);

  @override
  Future<String?> getHiveKey() async {
    return await _flutterSecureStorage.read(
      key: hiveKey,
    );
  }

  @override
  Future<void> setHiveKey(String value) async {
    await _flutterSecureStorage.write(
      key: hiveKey,
      value: value,
    );
  }
}
