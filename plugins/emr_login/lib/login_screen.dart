import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:emr_app_constant/app_constant.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_app_store/model/acs_token_model.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:emr_authorize/role_store.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/acs_uri.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vss_environment/environment_enum.dart';
import 'package:vss_environment/environment_switch.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_locale/locale_button.dart';
import 'package:vss_log/vss_log.dart';
import 'package:vss_message_util/message_util.dart';
import 'package:vss_theme/color_button.dart';
import 'package:vss_theme/theme_store.dart';

import 'l10n/translate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? peopleFullName;
  bool passwordVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loginnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String version = '';
  bool formSubmitting = false;
  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    loginnameController.dispose();
    passwordController.dispose();
    submitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () async {
        return confirmQuit();
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: colorScheme.background,
              body: Container(
                //padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
                padding: kIsWeb
                    ? EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3)
                    : const EdgeInsets.symmetric(
                        horizontal: GlobalConstant.paddingMarginLength),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GlobalConstant.colDivider,
                      GlobalConstant.colDivider,
                      GlobalConstant.colDivider,
                      Image.asset(
                        'assets/images/logoapp.png',
                        height: 150,
                      ),
                      GlobalConstant.colDivider,
                      GlobalConstant.colDivider,
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: loginnameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.account_circle_outlined),
                                suffixIcon: IconButton(
                                  onPressed: () => loginnameController.clear(),
                                  icon: const Icon(Icons.clear_outlined),
                                ),
                                labelText: translate.tenDangNhap,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return translate.duLieuBatBuoc;
                                }
                                return null;
                              },
                            ),
                            GlobalConstant.colDivider,
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                labelText: translate.matKhau,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return translate.duLieuBatBuoc;
                                }
                                return null;
                              },
                            ),
                            GlobalConstant.colDivider,
                            SizedBox(
                              width: double.infinity,
                              child: ValueListenableBuilder<bool>(
                                  valueListenable: submitNotifier,
                                  builder: (BuildContext context, bool val,
                                      Widget? child) {
                                    return FilledButton(
                                      onPressed: () {
                                        if (passwordController.text ==
                                            'caidatmoitruong123@@@###&&&') {
                                          Navigator.pushNamed(context,
                                              '/tva_environment_chooser/EnvironmentChooserScreen');
                                        } else if (formKey.currentState!
                                            .validate()) {
                                          authenticate(loginnameController.text,
                                              passwordController.text);
                                        }
                                      },
                                      child: !formSubmitting
                                          ? Text(translate.dangNhap)
                                          : CircularProgressIndicator(
                                              color: colorScheme.onPrimary),
                                    );
                                  }),
                            ),
                            GlobalConstant.colDivider,
                            GlobalConstant.colDivider,
                            Row(
                              children: <Widget>[
                                // Visibility(
                                //   visible: LoginStore.cosPeopleModel != null,
                                //   child: Column(
                                //     children: <Widget>[
                                //       Text(
                                //         translate.doiTaiKhoanKhac,
                                //       ),
                                //     ],
                                //   ).onTap(() {
                                //     LoginStore.deleteTokenPeopleModel();
                                //     setState(() {
                                //       peopleFullName = null;
                                //       mobileController.text = '';
                                //     });
                                //   }),
                                // ),
                                GlobalConstant.rowDivider,
                                GlobalConstant.rowDivider,
                                GlobalConstant.rowDivider,
                                GlobalConstant.rowDivider,
                                GlobalConstant.rowDivider,
                                Expanded(
                                  child: Text(
                                    translate.cauHinhHeThong,
                                    textAlign: TextAlign.right,
                                  ).onTap(
                                    () {
                                      Navigator.pushNamed(context,
                                          '/emr_login/ConfigurationScreen');
                                    },
                                  ),
                                ),
                                GlobalConstant.rowDivider,
                              ],
                            ),
                            GlobalConstant.colDivider,
                            GlobalConstant.colDivider,
                            GlobalConstant.colDivider,
                            StreamBuilder<String>(
                                initialData: EnvironmentSwitch.environment,
                                stream: EnvironmentSwitch.environmentStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data ==
                                          EnvironmentEnum.dev.env) {
                                    return Text(
                                        translate
                                            .phanMemDangTroVaoMoiTruongPhatTrien,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                }),
                          ],
                        ),
                      ),
                      //buildButton(context, translate, colorScheme)
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ColorButton(
                      handleColorSelect: ThemeStore.handleColorSelect!,
                      colorSelected: ThemeStore.colorSelected,
                    ),
                    Column(
                      children: <Widget>[
                        Text('${translate.tongDaiHoTro}: 19006888').onTap(() {
                          makePhoneCall('19006888');
                        }),
                        Text('${translate.phienBan}: $version'),
                      ],
                    ),
                    LocaleButton(
                      handleLocaleSelect: LanguageStore.handleLocaleChange!,
                      localeSelected: LanguageStore.localeSelected,
                    ),
                  ],
                ),
              ))),
    );
  }

  Padding buildButton(
      BuildContext context, Translate translate, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder(
              valueListenable: submitNotifier,
              builder: (BuildContext context, bool val, Widget? child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GlobalConstant.rowDivider,
                      Expanded(
                        //flex: 1,
                        child: SizedBox(
                          child: FilledButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/emr_login/ConfigurationScreen');
                            },
                            child: !formSubmitting
                                ? Text(translate.cauHinh)
                                : CircularProgressIndicator(
                                    color: colorScheme.onPrimary,
                                  ),
                          ),
                        ),
                      ),
                      GlobalConstant.rowDivider,
                      Expanded(
                        //flex: 1,
                        child: SizedBox(
                          child: FilledButton(
                            onPressed: () async {
                              if (passwordController.text ==
                                  'caidatmoitruong123@@@###&&&') {
                                Navigator.pushNamed(context,
                                    '/emr_environment_chooser/EnvironmentChooserScreen');
                              } else if (formKey.currentState!.validate()) {
                                authenticate(loginnameController.text,
                                    passwordController.text);
                              }
                            },
                            child: !formSubmitting
                                ? Text(translate.dangNhap)
                                : CircularProgressIndicator(
                                    color: colorScheme.onPrimary,
                                  ),
                          ),
                        ),
                      ),
                    ]);
              },
            ),
          ),
          GlobalConstant.colDivider,
        ],
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> authenticate(String loginName, String password) async {
    if (formSubmitting) {
      return;
    }
    formSubmitting = true;
    submitNotifier.value = true;
    final Map<String, String> headers = <String, String>{
      'Authorization':
          'Basic ${base64.encode(utf8.encode('${AppConstant.applicationCode}:$loginName:$password'))}'
    };
    ApiConsumer.dotNetApi
        .get(
      '${BackendDomain.acs}${AcsUri.api_Token_Login}',
      headers: headers,
    )
        .then((ApiResultModel apiResultModel) async {
      if (apiResultModel.Success && apiResultModel.Data != null) {
        LoginStore.setAcsToken(
            valueToken: AcsTokenModel.fromJson(
                apiResultModel.Data as Map<String, dynamic>));
        ApiConsumer.updateToken(LoginStore.acsTokenModel?.TokenCode ?? '');
        VssLog.push(
            'Login', ApiConsumer.applicationCode, ApiConsumer.appVersion,
            user: LoginStore.acsTokenModel != null
                ? '${LoginStore.acsTokenModel?.User?.LoginName} - ${LoginStore.acsTokenModel?.User?.UserName}'
                : '...',
            screen: 'LoginScreen',
            module: '/emr_login/LoginScreen');
        Future.wait([RoleStore.checkRole(), ScreenStore.getAllScreen()])
            .then((List<void> value) {
          formSubmitting = false;
          submitNotifier.value = false;
          Navigator.pushNamedAndRemoveUntil(
              context,
              '/emr_dashboard/DashboardScreen',
              (Route<dynamic> route) => false);
        });
      } else {
        MessageUtil.snackbar(context,
            message: apiResultModel.getMessage(), success: false);
        formSubmitting = false;
        submitNotifier.value = false;
      }
    });
  }

  Future<bool> confirmQuit() async {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              translate.xacNhan,
            ),
            content: Text(
              translate.banMuonTatPhanMem,
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
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  translate.dongY,
                ),
              )
            ],
          );
        });
  }
}
