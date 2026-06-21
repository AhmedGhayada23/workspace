import 'package:workspace/core/config/constants.dart';
import 'package:workspace/core/config/storage/local_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearToken();
  Future<void> cacheUserType(String type);

  /// حفظ بيانات "تذكّرني".
  Future<void> saveRememberedCredentials({required String email, required String password});
  Future<void> clearRememberedCredentials();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> cacheToken(String token) => storage.writeValue(Constants.token, token);

  @override
  String? getToken() => storage.readValue<String>(Constants.token);

  @override
  Future<void> clearToken() => storage.removeKey(Constants.token);

  @override
  Future<void> cacheUserType(String type) => storage.writeValue(Constants.userType, type);

  @override
  Future<void> saveRememberedCredentials({required String email, required String password}) async {
    await storage.writeValue('email', email);
    await storage.writeValue('password', password);
    await storage.writeValue('remember_me', true);
  }

  @override
  Future<void> clearRememberedCredentials() async {
    await storage.removeKey('email');
    await storage.removeKey('password');
    await storage.writeValue('remember_me', false);
  }
}
