abstract class SecureStorage {
  Future<void> setHiveKey(String value);
  Future<String?> getHiveKey();
}
