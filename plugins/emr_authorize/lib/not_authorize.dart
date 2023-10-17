import 'package:flutter/material.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_locale/language_store.dart';

import 'l10n/translate.dart';
import 'role_enum.dart';

class NotAuthorize extends StatelessWidget {
  const NotAuthorize({super.key, required this.roleEnum});
  final RoleEnum roleEnum;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (roleEnum == RoleEnum.register) register(context),
        if (roleEnum == RoleEnum.tester) tester(context),
        if (roleEnum == RoleEnum.ticketSeller) ticketSeller(context),
        if (roleEnum == RoleEnum.supervisor) verified(context),
      ],
    );
  }

  Widget ticketSeller(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: Column(
          children: <Widget>[
            Text(
              translate.longtext_khongCoVaiTroTiketSeller,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget verified(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: Column(
          children: <Widget>[
            Text(
              translate.longtext_khongCoVaiTroSupervisor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget register(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: Column(
          children: <Widget>[
            Text(
              translate.longtext_khongCoVaiTroRegister,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget tester(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: Column(
          children: <Widget>[
            Text(
              translate.longtext_khongCoVaiTroTester,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
