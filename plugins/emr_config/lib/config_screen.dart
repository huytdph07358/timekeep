import 'package:flutter/material.dart';
//import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:emr_app_store/not_found_screen.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:emr_authorize/role_store.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_locale/locale_button.dart';
import 'package:vss_theme/color_button.dart';
import 'package:vss_theme/theme_store.dart';

import 'l10n/translate.dart';
//import 'role_screen.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final String screenLink = '/emr_config/ConfigScreen';
  String langageName = '';
  String iconLanguage = 'assets/images/flag/vi.png';
  String version = '';

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        langageName = LanguageStore.localeSelected.languageCode;
        iconLanguage =
            'assets/images/flag/${LanguageStore.localeSelected.languageCode}.png';
        version = packageInfo.version;
      });
    });

    // if (!ScreenStore.checkExists(screenLink)) {
    //   return Scaffold(
    //     appBar: EmrAppBar(
    //       title: translate.caiDat,
    //       screenLink: screenLink,
    //     ),
    //     body: Container(
    //       padding: const EdgeInsets.all(
    //         GlobalConstant.paddingMarginLength,
    //       ),
    //       child: const NotFoundScreen(),
    //     ),
    //   );
    // }

    return Scaffold(
        appBar: EmrAppBar(
          title: translate.caiDat,
          showHome: false,
          screenLink: screenLink,
        ),
        body: Container(
          padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
          child: Column(
            children: <Widget>[
              colorConfig(),
              const Divider(),
              languageConfig(),
              const Divider(),
              backgroundConfig(),
              // const Divider(),
              // roleConfig(),
            ],
          ),
        ));
  }

  Row languageConfig() {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          translate.ngonNgu,
        ),
        Row(
          children: <Widget>[
            CircleAvatar(backgroundImage: AssetImage(iconLanguage), radius: 6),
            Text(
              langageName,
            ),
            LocaleButton(
              handleLocaleSelect: LanguageStore.handleLocaleChange!,
              localeSelected: LanguageStore.localeSelected,
            ),
          ],
        ),
      ],
    );
  }

  Row colorConfig() {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          translate.mauSac,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CircleAvatar(backgroundColor: colorScheme.primary, radius: 6),
            ColorButton(
              handleColorSelect: ThemeStore.handleColorSelect!,
              colorSelected: ThemeStore.colorSelected,
            ),
          ],
        ),
      ],
    );
  }

  Row backgroundConfig() {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          translate.nen,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              getThemeModeByEnum(ThemeStore.getThemeMode),
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.dark_mode_outlined,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              itemBuilder: (BuildContext context) {
                return List.generate(ThemeMode.values.length, (int index) {
                  final ThemeMode currentThemeMode =
                      ThemeMode.values.elementAt(index);
                  return PopupMenuItem(
                    value: index,
                    enabled: currentThemeMode != ThemeStore.getThemeMode,
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(getThemeModeByEnum(currentThemeMode)),
                        ),
                      ],
                    ),
                  );
                });
              },
              onSelected: (int index) {
                ThemeStore.changeThemeMode(index);
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget roleConfig() {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        //const RoleScreen().launch(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            translate.vaiTro,
          ),
          Expanded(
              child: Text(
            RoleStore.getRoleCode(),
            textAlign: TextAlign.right,
            overflow: TextOverflow.clip,
          )),
        ],
      ),
    );
  }

  String getThemeModeByEnum(ThemeMode themeMode) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    if (themeMode == ThemeMode.system) {
      return translate.heThong;
    } else if (themeMode == ThemeMode.light) {
      return translate.sang;
    } else {
      return translate.toi;
    }
  }
}
