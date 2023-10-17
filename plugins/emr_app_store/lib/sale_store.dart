import 'package:nb_utils/nb_utils.dart';

class SaleStore {
  /// tripCode
  static const String _tripCodeSharePrefKey =
      'emr_app_store.SaleStore._tripCodeSharePrefKey';

  static String? get tripCode {
    bool found = false;
    final Set<String> keySet = sharedPreferences.getKeys();
    for (final String key in keySet) {
      if (key == _tripCodeSharePrefKey) {
        found = true;
        break;
      }
    }
    if (!found) {
      return null;
    }
    return getStringAsync(_tripCodeSharePrefKey);
  }

  static void setTripCode(String value) {
    setValue(_tripCodeSharePrefKey, value);
  }

  static void removeTripCode() {
    removeKey(_tripCodeSharePrefKey);
  }

  /// session
  static const String _sessionSharePrefKey =
      'emr_app_store.SaleStore._sessionSharePrefKey';

  static String? get session {
    bool found = false;
    final Set<String> keySet = sharedPreferences.getKeys();
    for (final String key in keySet) {
      if (key == _sessionSharePrefKey) {
        found = true;
        break;
      }
    }
    if (!found) {
      return null;
    }
    return getStringAsync(_sessionSharePrefKey);
  }

  static void setSession(String value) {
    setValue(_sessionSharePrefKey, value);
  }

  static void removeSession() {
    removeKey(_sessionSharePrefKey);
  }

  /// price
  static const String _priceSharePrefKey =
      'emr_app_store.SaleStore._priceSharePrefKey';

  static int? get price {
    bool found = false;
    final Set<String> keySet = sharedPreferences.getKeys();
    for (final String key in keySet) {
      if (key == _priceSharePrefKey) {
        found = true;
        break;
      }
    }
    if (!found) {
      return null;
    }
    return getIntAsync(_priceSharePrefKey);
  }

  static void setPrice(int value) {
    setValue(_priceSharePrefKey, value);
  }

  static void removePrice() {
    removeKey(_priceSharePrefKey);
  }
}
