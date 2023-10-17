import 'package:flutter/material.dart';
import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:vss_environment/environment_enum.dart';
import 'package:vss_environment/environment_switch.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_locale/language_store.dart';

import 'l10n/translate.dart';

class EnvironmentChooserScreen extends StatefulWidget {
  const EnvironmentChooserScreen({super.key});

  @override
  State<EnvironmentChooserScreen> createState() =>
      _EnvironmentChooserScreenState();
}

class _EnvironmentChooserScreenState extends State<EnvironmentChooserScreen> {
  final String screenLink = '/emr_environment_chooser/EnvironmentChooserScreen';
  String environment = EnvironmentSwitch.environment;

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);

    return Scaffold(
      appBar: EmrAppBar(
        title: translate.chonMoiTruong,
        showHome: false,
        screenLink: screenLink,
      ),
      body: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: Center(
          child: SegmentedButton<String>(
            segments: <ButtonSegment<String>>[
              ButtonSegment<String>(
                value: EnvironmentEnum.dev.env,
                label: const Text('Dev'),
              ),
              ButtonSegment<String>(
                value: EnvironmentEnum.live.env,
                label: const Text('Live'),
              ),
            ],
            selected: <String>{environment},
            onSelectionChanged: (Set<String> newSelection) {
              setState(() {
                environment = newSelection.first;
                EnvironmentSwitch.setEnvironment(environment);
              });
            },
          ),
        ),
      ),
    );
  }
}
