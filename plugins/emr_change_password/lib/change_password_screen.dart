import 'package:flutter/material.dart';
import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_app_store/not_found_screen.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/acs_uri.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_message_util/message_util.dart';

import 'l10n/translate.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final String screenLink = '/emr_change_password/ChangePasswordScreen';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _currentPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _confirmPasswordVisible = true;
  late FocusNode _focusNode;
  final ValueNotifier<bool> _submitNotifier = ValueNotifier<bool>(false);
  bool _formSubmitting = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _submitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (!ScreenStore.checkExists(screenLink)) {
      return Scaffold(
        appBar: EmrAppBar(
          title: translate.doiMatKhau,
          screenLink: screenLink,
        ),
        body: Container(
          padding: const EdgeInsets.all(
            GlobalConstant.paddingMarginLength,
          ),
          child: const NotFoundScreen(),
        ),
      );
    }

    return Scaffold(
      appBar: EmrAppBar(
        title: translate.doiMatKhau,
        showHome: false,
        screenLink: screenLink,
      ),
      body: Container(
          padding: const EdgeInsets.all(
            GlobalConstant.paddingMarginLength,
          ),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    focusNode: _focusNode,
                    controller: _currentPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _currentPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _currentPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentPasswordVisible = !_currentPasswordVisible;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                      labelText: translate.matKhauHienTai,
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
                    controller: _newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _newPasswordVisible,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: _newPasswordVisible
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              _newPasswordVisible = !_newPasswordVisible;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        labelText: translate.matKhauMoi),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return translate.duLieuBatBuoc;
                      }
                      return null;
                    },
                  ),
                  GlobalConstant.colDivider,
                  TextFormField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _confirmPasswordVisible,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: _confirmPasswordVisible
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        labelText: translate.nhapLaiMatKhauMoi),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return translate.duLieuBatBuoc;
                      }
                      if (value != _newPasswordController.text) {
                        return translate.khongKhopVoiMatKhauMoi;
                      }

                      return null;
                    },
                  ),
                  GlobalConstant.colDivider,
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder<bool>(
                        valueListenable: _submitNotifier,
                        builder:
                            (BuildContext context, bool val, Widget? child) {
                          return FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                changePassword();
                              }
                            },
                            child: !_formSubmitting
                                ? Text(translate.dongY)
                                : CircularProgressIndicator(
                                    color: colorScheme.onPrimary),
                          );
                        }),
                  ),
                ],
              ))),
    );
  }

  void changePassword() {
    try {
      if (_formSubmitting) {
        return;
      }
      _formSubmitting = true;
      _submitNotifier.value = true;

      ApiConsumer.dotNetApi.post(
          '${BackendDomain.acs}${AcsUri.api_AcsUser_ChangePassword}',
          body: <String, Map<String, String?>>{
            'ApiData': <String, String?>{
              'LOGIN_NAME': LoginStore.acsTokenModel?.User?.LoginName,
              'PASSWORD__OLD': _currentPasswordController.text,
              'PASSWORD__NEW': _confirmPasswordController.text,
            }
          }).then((ApiResultModel apiResultModel) async {
        _formSubmitting = false;
        _submitNotifier.value = false;
        if (apiResultModel.Success && apiResultModel.Data == true) {
          MessageUtil.snackbar(context, success: true);
          setState(() {
            _currentPasswordController.text = '';
            _newPasswordController.text = '';
            _confirmPasswordController.text = '';
            _focusNode.requestFocus();
          });
        } else {
          MessageUtil.snackbar(context,
              message: apiResultModel.getMessage(), success: false);
        }
      });
    } catch (e) {
      MessageUtil.snackbar(context, success: false);
    }
  }
}
