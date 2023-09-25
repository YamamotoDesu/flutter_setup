abstract class SettingRepository {
  Future<bool> addToBox<T>(String key, T? value);
  Future<T?> getFromBox<T>(String key);
}
