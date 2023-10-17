import 'dart:async';

import 'package:nb_utils/nb_utils.dart';
import 'package:emr_app_store/model/tvb_screen_model.dart';
import 'package:emr_app_store/screen_store.dart';

class FavouriteScreenStore {
  static const String sharePrefKey =
      'vss_screen.FavouriteScreenStore.sharePrefKey';

  static final StreamController<List<String>> _streamController =
      StreamController<List<String>>.broadcast();
  static Stream<List<String>> get stream => _streamController.stream;

  static void _updateScreenLinkList(List<String> screenLinkList) {
    while (screenLinkList.length > 4) {
      screenLinkList.removeAt(0);
    }
    setValue(sharePrefKey, screenLinkList);
    _streamController.sink.add(screenLinkList);
  }

  static List<String> getFavouriteScreenLinkList() {
    final List<String> screenLinkList =
        getStringListAsync(sharePrefKey) ?? <String>[];
    if (screenLinkList.isEmpty) {
      screenLinkList.add('/tva_bill/BillScreen');
      screenLinkList.add('/tva_van_mieu_quoc_tu_giam/VanMieuQuocTuGiamScreen');
      screenLinkList.add('/tva_topup_mobile/TopupMobileScreen');
      screenLinkList.add('/tva_collaborator/CollaboratorScreen');
      _updateScreenLinkList(screenLinkList);
    }
    return screenLinkList;
  }

  static void addFavouriteScreenLink(String screenLink) {
    final List<String> screenLinkList = getFavouriteScreenLinkList();

    screenLinkList.removeAt(0);
    screenLinkList.add(screenLink);
    _updateScreenLinkList(screenLinkList);
  }

  static List<TvbScreenModel> getFavouriteScreen() {
    final List<String> screenLinkList = getFavouriteScreenLinkList();
    return screenLinkToScreen(screenLinkList);
  }

  static List<TvbScreenModel> screenLinkToScreen(List<String> screenLinkList) {
    final List<TvbScreenModel> result = <TvbScreenModel>[];
    for (final String element in screenLinkList) {
      for (final TvbScreenModel screen in ScreenStore.getAllMenu()) {
        if (screen.screenLink == element) {
          result.add(screen);
          break;
        }
      }
    }
    return result;
  }
}
