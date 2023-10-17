import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/nms_uri.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';

class FirebaseStore {
  static const String tokenFirebaseOnPref = 'tokenFirebase';
  static String? tokenFirebase = '';

  static Future<void> setTokenFirebase({required String? value}) async {
    try {
      tokenFirebase = value ?? '';
      setValue(tokenFirebaseOnPref, tokenFirebase);
    } catch (e) {
      //Log.e(TAG, "Error registering plugin connectivity_plus, dev.fluttercommunity.plus.connectivity.ConnectivityPlugin", e);
    }
  }

  static Future<String?> getTokenFirebase() async {
    try {
      tokenFirebase = getStringAsync(tokenFirebaseOnPref);
      tokenFirebase ??= await FirebaseMessaging.instance.getToken();
    } catch (e) {
      //Log.e(TAG, "Error registering plugin connectivity_plus, dev.fluttercommunity.plus.connectivity.ConnectivityPlugin", e);
    }
    return tokenFirebase;
  }

  static Future<bool> registerDeviceToken() async {
    bool success = false;
    try {
      final String? fcmToken = await FirebaseStore.getTokenFirebase();
      final Map<String, dynamic> body = <String, dynamic>{
        'ApiData': <String, String>{
          'DeviceToken': fcmToken ?? '',
          'DeviceType': Platform.isIOS ? 'Ios' : 'Android',
        }
      };
      final String uri =
          '${BackendDomain.nms}${NmsUri.api_NmsDeviceToken_Register}';
      final ApiResultModel apiResultModel =
          await ApiConsumer.dotNetApi.post(uri, body: body);
      if (apiResultModel.Success) {
        success = true;
      }
    } catch (e) {
      //
    }
    return success;
  }
}
