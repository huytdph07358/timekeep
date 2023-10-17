import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/emr_uri.dart';

import 'model/tvb_screen_model.dart';

class ScreenStore {
  static List<TvbScreenModel> _allScreen = <TvbScreenModel>[];
  static List<TvbScreenModel> get allScreen => _allScreen;

  static Future<void> getAllScreen() async {
    final ApiResultModel apiResultModel = await ApiConsumer.dotNetCoreApi
        .get('${BackendDomain.emr}${EmrUri.api_VtxScreen_GetAll}');
    if (apiResultModel.Data != null) {
      _allScreen = (apiResultModel.Data as List)
          .map((e) => TvbScreenModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      _allScreen.clear();
    }
  }

  static List<TvbScreenModel> getAllMenu() {
    final List<TvbScreenModel> result = <TvbScreenModel>[];
    for (final TvbScreenModel screen in _allScreen) {
      if (screen.isMenu ?? false) {
        result.add(screen);
      }
    }
    return result;
  }

  static bool checkExists(String screenLink) {
    for (final TvbScreenModel screen in _allScreen) {
      if (screen.screenLink == screenLink) {
        return true;
      }
    }
    return false;
  }
}
