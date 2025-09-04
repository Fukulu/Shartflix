import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // TAG - WRITE
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // TAG - READ
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // TAG - DELETE
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // TAG - DELETE ALL
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
