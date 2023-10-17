import 'translate.dart';

/// The translations for English (`en`).
class TranslateEn extends Translate {
  TranslateEn([String locale = 'en']) : super(locale);

  @override
  String get longtext_khongCoVaiTroTiketSeller => 'You have not been declared as a bus ticket agent';

  @override
  String get longtext_khongCoVaiTroSupervisor => 'You need to be assigned the supervisor role to be able to use this feature';

  @override
  String get longtext_khongCoVaiTroRegister => 'You need to be assigned a device registration role to be able to use this feature';

  @override
  String get longtext_khongCoVaiTroTester => 'You need to be assigned the tester role to be able to use this feature';

  @override
  String get zzz => '';
}
