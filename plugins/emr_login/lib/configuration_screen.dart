import 'dart:convert';

import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_app_store/user_secure_storage.dart';
import 'package:emr_app_store/model/config_model.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:emr_app_constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_message_util/message_util.dart';

import 'l10n/translate.dart';
import 'model/sda_configapp_model.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  String? peopleFullName;
  bool passwordVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loginnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  String version = '';
  bool formSubmitting = false;
  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    ConfigModel? configModel = UserSecureStorage.getConfigModel();
    if (configModel != null) {
      controller.text = configModel.HOSPITAL_CODE!;
    }
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
    print('============>${UserSecureStorage.getConfigModel()}');
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GlobalConstant.colDivider,
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    GlobalConstant.colDivider,
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => controller.clear(),
                          icon: const Icon(Icons.clear_outlined),
                        ),
                        labelText: translate.maBenhVien,
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
                          builder:
                              (BuildContext context, bool val, Widget? child) {
                            return FilledButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  save();
                                }
                              },
                              child: !formSubmitting
                                  ? Text(translate.xacNhan)
                                  : CircularProgressIndicator(
                                      color: colorScheme.onPrimary),
                            );
                          }),
                    ),
                    GlobalConstant.colDivider,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save() async {
    if (formSubmitting) {
      return;
    }
    formSubmitting = true;
    submitNotifier.value = true;
    final Map<String, dynamic> apiData = <String, dynamic>{
      "ApiData": {
        'KEY_WORD': "",
        'KEY': "CONFIG_SERVER__HOSPITAL_CODE",
        'APP_CODE': AppConstant.applicationCode,
        'ORDER_FIELD': "MODIFY_TIME",
        'ORDER_DIRECTION': "DESC",
      }
    };
    SdaConfigappModel? sdaConfigappModel;
    List<SdaConfigappModel> result = <SdaConfigappModel>[];
    final ApiResultModel apiResultModels = await ApiConsumer.dotNetApi
        .getPaging('${BackendDomain.sda_init}${EmrUri.api_SdaConfigApp_Get}',
            apiData: apiData,
            commonParam: <String, dynamic>{
          'Limit': 100,
          'Start': 0,
        });

    print('????????????????${apiResultModels.Data}');

    if (apiResultModels.Data != null && apiResultModels.Data != []) {
      result = (apiResultModels.Data as List)
          .map((e) => SdaConfigappModel.fromJson(e))
          .toList();

      sdaConfigappModel = result.first;

      late ConfigModel configModel;
      print('bbbbbbbbbbbbbbbbbbbbbbbbbb${sdaConfigappModel.DEFAULT_VALUE}');
      List<ConfigModel> configModels =
          (json.decode(sdaConfigappModel.DEFAULT_VALUE.toString()) as List)
              .map((e) => ConfigModel.fromJson(e))
              .where((element) => element.HOSPITAL_CODE == controller.text)
              .toList();
      if (configModels.isNotEmpty) {
        configModel = configModels.first;
        await UserSecureStorage.setConfig(value: configModel);

        //ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, '/emr_login/LoginScreen', (Route<dynamic> route) => false);
        formSubmitting = false;
        submitNotifier.value = false;
      } else {
        formSubmitting = false;
        submitNotifier.value = false;
        MessageUtil.snackbar(context,
            message: 'Không tìm thấy mã bệnh viện', success: false);
      }
    } else {
      // ignore: use_build_context_synchronously
      MessageUtil.snackbar(context,
          message: apiResultModels.getMessage() ?? '', success: false);
      formSubmitting = false;
      submitNotifier.value = false;
    }
  }
}
