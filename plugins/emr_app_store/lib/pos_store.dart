import 'package:nb_utils/nb_utils.dart';

class PosStore {
  static const String _posCodeSharePrefKey =
      'emr_app_store.PosStore._posCodeSharePrefKey';

  static String? get posCode {
    bool found = false;
    final Set<String> keySet = sharedPreferences.getKeys();
    for (final String key in keySet) {
      if (key == _posCodeSharePrefKey) {
        found = true;
        break;
      }
    }
    if (!found) {
      return null;
    }
    return getStringAsync(_posCodeSharePrefKey);
  }

  static void setPosCode(String value) {
    setValue(_posCodeSharePrefKey, value);
  }

  static void removePosCode() {
    removeKey(_posCodeSharePrefKey);
  }
}
