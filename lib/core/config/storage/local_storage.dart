import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static LocalStorage? _instance;
  late GetStorage _storage;

  LocalStorage._();

  Future<void> initStorage() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  factory LocalStorage() {
    return _instance ??= LocalStorage._();
  }

  Future<void> writeValue(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  T? readValue<T>(String key) {
    return _storage.read(key);
  }

  Future<void> writeList(String key, List<String> value) async {
    await _storage.write(key, value);
  }

  Future<List<String>> readList(String key) async {
    final list = _storage.read(key);
    if (list != null && list is List) {
      return List<String>.from(list);
    }
    return [];
  }

  Future<void> removeKey(String key) async {
    await _storage.remove(key);
  }
}
