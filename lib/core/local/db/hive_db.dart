import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/local/db/hive_box_key.dart';
import 'package:flutter_setup/core/local/db/hive_constant.dart';
import 'package:flutter_setup/core/local/secure_storage/seucre_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_setup/core/local/secure_storage/secure_storage_impl.dart';

final hiveDbProvider = Provider<HiveDb>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return HiveDb(secureStorage);
});

class HiveDb {
  final SecureStorage _secureStorage;
  HiveDb(this._secureStorage);

  Future<void> init() async {
    await Hive.initFlutter(hiveDb);

    String? encryptionKey = await _secureStorage.getHiveKey();
    if (encryptionKey == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.setHiveKey(base64UrlEncode(key));
      encryptionKey = await _secureStorage.getHiveKey();
    }

    if (encryptionKey != null) {
      final key = base64Url.decode(encryptionKey);
      await Hive.openBox<dynamic>(
        settingBox,
        encryptionCipher: HiveAesCipher(key),
      );
    }
  }
}
