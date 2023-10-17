import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SaltStore {
  static String? _salt;
  static const String _saltKey = 'emr_app_store.SaltStore._saltKey';

  static IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'demo',
      );

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static Future<void> setSalt({required String value}) async {
    _salt = value;
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(
      key: _saltKey,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  static Future<String?> getSalt() async {
    if (_salt != null) {
      return _salt;
    } else {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      final String? value = await storage.read(
          key: _saltKey,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions());
      if (value != null) {
        _salt = value;
      }
      return _salt;
    }
  }

  static Future<void> deleteSalt() async {
    _salt = null;
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: _saltKey);
  }
}
