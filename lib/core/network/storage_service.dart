import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;
  static const String _sessionTokenKey = 'vendure_session_token';

  SecureStorageService(this._storage);

  Future<void> saveSessionToken(String token) async {
    await _storage.write(key: _sessionTokenKey, value: token);
  }

  Future<String?> getSessionToken() async {
    return await _storage.read(key: _sessionTokenKey);
  }

  Future<void> deleteSessionToken() async {
    await _storage.delete(key: _sessionTokenKey);
  }
}

@riverpod
SecureStorageService secureStorageService(Ref ref) {
  return SecureStorageService(const FlutterSecureStorage());
}
