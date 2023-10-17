import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vss_environment/environment_enum.dart';
import 'package:vss_environment/environment_switch.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_log/vss_log.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/acs_uri.dart';

import 'favourite_screen_block.dart';
import 'l10n/translate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String version = '';
  bool formSubmitting = false;
  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          translate.veXe,
          style: TextStyle(
            color: colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      drawer: buildDrawer(),
      body: Container(
          padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
          child: Column(children: const <Widget>[
            FavouriteScreenBlock(),
          ])),
    );
  }

  Widget buildDrawer() {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          InkWell(
            onTap: () {
              //Navigator.pushNamed(context, '/emr_profile/DetailProfileScreen');//TODO
            },
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: avatar(),
            ),
          ),
          ////phuongdt comment,bao giờ có code mình hình thì bỏ comment
          // ListTile(
          //   leading: const Icon(Icons.notifications_none),
          //   title: Text(translate.thongBao),
          //   onTap: () {
          //     Navigator.pushNamed(
          //         context, '/emr_notification/NotificationScreen');
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(translate.caiDat),
            onTap: () {
              Navigator.pushNamed(context, '/emr_config/ConfigScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: Text(translate.doiMatKhau),
            onTap: () {
              Navigator.pushNamed(
                  context, '/emr_change_password/ChangePasswordScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(translate.dangXuat),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        translate.xacNhan,
                      ),
                      content: Text(
                        translate.banMuonDangXuat,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            finish(context);
                          },
                          child: Text(
                            translate.boQua,
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                            valueListenable: submitNotifier,
                            builder: (BuildContext context, bool val,
                                Widget? child) {
                              return TextButton(
                                onPressed: () {
                                  if (formSubmitting) {
                                    return;
                                  }
                                  formSubmitting = true;
                                  submitNotifier.value = true;

                                  ApiConsumer.dotNetApi
                                      .post(
                                          '${BackendDomain.acs}${AcsUri.api_Token_Logout}')
                                      .then((ApiResultModel apiResultModel) {
                                    finish(context);
                                    LoginStore.deleteToken();
                                    VssLog.push(
                                        'Logout',
                                        ApiConsumer.applicationCode,
                                        ApiConsumer.appVersion,
                                        user: LoginStore.acsTokenModel != null
                                            ? '${LoginStore.acsTokenModel?.User?.LoginName} - ${LoginStore.acsTokenModel?.User?.UserName}'
                                            : '...',
                                        screen: 'HomeScreen',
                                        module: '/');
                                    formSubmitting = false;
                                    submitNotifier.value = false;
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/emr_login/LoginScreen',
                                            (Route<dynamic> route) => false);
                                  });
                                },
                                child: !formSubmitting
                                    ? Text(translate.dongY)
                                    : const CircularProgressIndicator(),
                              );
                            }),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: Text(
                '${translate.phienBan}: $version${EnvironmentSwitch.environment == EnvironmentEnum.dev.env ? '-dev' : ''}'),
          ),
        ],
      ),
    );
  }

  Widget avatar() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                overflow: TextOverflow.ellipsis,
                LoginStore.acsTokenModel?.User?.UserName ?? '',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                LoginStore.acsTokenModel?.User?.LoginName ?? '',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
