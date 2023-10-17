import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './model/config_model.dart';
import 'package:emr_backend_domain/backend_domain.dart';

class UserSecureStorage {
  static IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'demo',
      );

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static ConfigModel? _configModel;

  // static final List<ConfigurationModel> _ticket = <ConfigurationModel>[];
  static const String _configKey = 'emr_app_store.UserSecureStorage._ConfigKey';

  static Future<void> init() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final String? configData = await storage.read(
        key: _configKey,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    if (configData != null) {
      _configModel = ConfigModel.fromJson(jsonDecode(configData));
      BackendDomain.setAcsUri(_configModel!.HISPITAL_CONFIG!.acsuri!);
      BackendDomain.setEmrUri(_configModel!.HISPITAL_CONFIG!.emruri!);
      BackendDomain.setSdaUri(_configModel!.HISPITAL_CONFIG!.sdauri!);
    }
  }

  static Future<void> setConfig({required ConfigModel value}) async {
    _configModel = value;
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(
      key: _configKey,
      value: json.encode(value.toJson()),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    BackendDomain.setAcsUri(_configModel!.HISPITAL_CONFIG!.acsuri!);
    BackendDomain.setEmrUri(_configModel!.HISPITAL_CONFIG!.emruri!);
    BackendDomain.setSdaUri(_configModel!.HISPITAL_CONFIG!.sdauri!);
  }

  static ConfigModel? getConfigModel() {
    return _configModel;
  }
}
