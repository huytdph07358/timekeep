import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/acs_uri.dart';

import 'firebase_store.dart';
import 'model/acs_token_model.dart';

class LoginStore {
  static AcsTokenModel? acsTokenModel;

  static IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'demo',
      );

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static Future<void> setAcsToken({required AcsTokenModel valueToken}) async {
    acsTokenModel = valueToken;
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      final String value = jsonEncode(valueToken);
      await storage.write(
        key: 'token',
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
      //Đăng ký lại thiết bị trên backend Nms để upate login token acs cho tokenfirebase
      await FirebaseStore.registerDeviceToken();
    } catch (e) {
      //
    }
  }

  static Future<AcsTokenModel?> getAcsToken() async {
    if (acsTokenModel != null) {
      return acsTokenModel;
    } else {
      try {
        const FlutterSecureStorage storage = FlutterSecureStorage();
        final String? value = await storage.read(
            key: 'token',
            iOptions: _getIOSOptions(),
            aOptions: _getAndroidOptions());
        if (value != null) {
          acsTokenModel =
              AcsTokenModel.fromJson(jsonDecode(value) as Map<String, dynamic>);
        }
      } catch (e) {
        //
      }
      return acsTokenModel;
    }
  }

  static Future<void> initTokenServerAndLocal() async {
    LoginStore.acsTokenModel = await LoginStore.getAcsToken();
    if (LoginStore.acsTokenModel != null &&
        LoginStore.acsTokenModel?.TokenCode != null) {
      ApiConsumer.updateToken(LoginStore.acsTokenModel?.TokenCode ?? '');
    }
  }

  static void deleteToken() {
    acsTokenModel = null;
    const FlutterSecureStorage storage = FlutterSecureStorage();
    storage.delete(
        key: 'token',
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }
}
