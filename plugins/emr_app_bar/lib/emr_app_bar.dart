import 'package:flutter/material.dart';
import 'package:emr_app_constant/app_constant.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_app_store/model/tvb_screen_model.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/vplus_uri.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_vplus_api/vplus_api.dart';
import 'package:vss_vplus_api/vplus_get_result_model.dart';

class EmrAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmrAppBar({
    super.key,
    required this.screenLink,
    this.title,
    this.forceTitle,
    this.showLeading = true,
    this.showHome = true,
    this.bottom,
  });

  final String screenLink;
  final String? title;
  final String? forceTitle;
  final bool showLeading;
  final bool showHome;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    String screenName = title ?? '';
    for (final TvbScreenModel screen in ScreenStore.allScreen) {
      if (screen.screenLink == screenLink) {
        screenName = (screen.names != null &&
                screen.names!
                    .containsKey(LanguageStore.localeSelected.languageCode))
            ? screen.names![LanguageStore.localeSelected.languageCode]!
            : screen.screenName ?? title ?? '';
        break;
      }
    }

    return AppBar(
      backgroundColor: colorScheme.primary,
      leading: Container(
        child: showLeading && Navigator.of(context).canPop()
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: colorScheme.onPrimary,
                ),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : const SizedBox.shrink(),
      ),
      actions: <Widget>[
        FutureBuilder<bool>(
            future: checkExistsQuestion(screenLink),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              Widget child;
              if (snapshot.hasData && (snapshot.data ?? false)) {
                child = IconButton(
                    icon: Icon(
                      Icons.help_outline_outlined,
                      color: colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      if (screenLink != null) {
                        Navigator.pushNamed(context,
                            '/vss_common_question/CommonQuestionScreen',
                            arguments: <String, String>{
                              'screenLink': screenLink!
                            });
                      }
                    });
              } else {
                child = const SizedBox.shrink();
              }
              return child;
            }),
        if (showHome && Navigator.of(context).canPop()) //&&
          if (LoginStore.acsTokenModel != null &&
              LoginStore.acsTokenModel?.TokenCode != null)
            IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: colorScheme.onPrimary,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/emr_dashboard/DashboardScreen',
                      (Route<dynamic> route) => false);
                })
          else
            const SizedBox.shrink(),
      ],
      title: Text(
        forceTitle ?? screenName,
        style: textTheme.bodyLarge!.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
      bottom: bottom,
    );
  }

  Future<bool> checkExistsQuestion(String? screenLink) async {
    try {
      if (screenLink == null) {
        return false;
      }

      const int limit = 1;
      final String param =
          'limit=$limit&tự_trả_lời=Y&mã_chức_năng=$screenLink&mã_phần_mềm=${AppConstant.applicationCode}';
      final VplusGetResultModel vplusGetResultModel = await VplusApi.get(
          '${BackendDomain.vplus}${VplusUri.hoidap_hoidap}?$param');
      if (vplusGetResultModel.count > 0) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  @override
  Size get preferredSize {
    return bottom == null
        ? const Size.fromHeight(kToolbarHeight)
        : const Size.fromHeight(
            105); //code tạm, nếu tìm được độ cao bottom thì + với kToolbarHeight là độ cao cần set
  }
}
