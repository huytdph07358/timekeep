import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vss_log/vss_log.dart';
import 'package:emr_app_constant/app_constant.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_app_store/model/tvb_screen_model.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:uuid/uuid.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_navigator/route_builders.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> _sendScreenView(PageRoute<dynamic> route) async {
    try {
      String? screenLink = route.settings.name;
      String? screenName = route.settings.name;
      final TvbScreenModel? module = ScreenStore.allScreen
              .any((TvbScreenModel element) => element.screenLink == screenLink)
          ? ScreenStore.allScreen.firstWhere(
              (TvbScreenModel element) => element.screenLink == screenLink)
          : null;
      if (module != null) {
        screenLink = module.screenLink;
      } else {
        if (screenLink == '/') {
          screenName = 'Trang chủ';
        } else if (screenLink == '/vss_login/LoginScreen') {
          screenName = 'Đăng nhập';
        } else if (screenName == '') {
          final SlideBottomRoute<dynamic> bottomRoute =
              route as SlideBottomRoute<dynamic>;
          screenName = bottomRoute.widget.runtimeType.toString();
          screenLink = bottomRoute.widget.runtimeType.toString();
        }
      }
      if (screenName != null && screenName.isNotEmpty) {
        VssLog.push(
            'screen_view', ApiConsumer.applicationCode, ApiConsumer.appVersion,
            user: LoginStore.acsTokenModel != null
                ? '${LoginStore.acsTokenModel?.User?.LoginName} - ${LoginStore.acsTokenModel?.User?.UserName}'
                : '...',
            screen: screenName ?? '',
            module: screenLink ?? '');
        // await FirebaseAnalytics.instance.logEvent(
        //   name: 'screen_view',
        //   parameters: <String, String?>{
        //     'firebase_screen': screenName,
        //     'firebase_screen_class': screenLink,
        //   },
        // );
      }
    } catch (ex) {
      log(ex);
    }
  }

  Future<void> createLogActivity(String screenName, String screenLink) async {
    final String uuid = const Uuid().v1();
    final Map<String, dynamic> body = <String, dynamic>{
      'ApiData': [
        <String, String>{
          'KEY': uuid,
          'MÃ_PHẦN_MỀM': AppConstant.applicationCode,
          'KEY': screenLink,
          'PHIÊN_BẢN': '',
        }
      ]
    };
    const String uri =
        'http://log.vietsens.vn/api/LogModuleActivity/CreateList';
    final ApiResultModel apiResultModel =
        await ApiConsumer.dotNetApi.post(uri, body: body);
    if (apiResultModel.Success) {}
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
