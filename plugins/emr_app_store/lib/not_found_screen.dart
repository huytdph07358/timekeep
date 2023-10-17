import 'package:flutter/material.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_locale/language_store.dart';

import 'l10n/translate.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: Text(
          translate.longtext_baoTriChucNang,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
