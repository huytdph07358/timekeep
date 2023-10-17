import 'translate.dart';

/// The translations for English (`en`).
class TranslateEn extends Translate {
  TranslateEn([String locale = 'en']) : super(locale);

  @override
  String get heThong => 'System';

  @override
  String get sang => 'Light';

  @override
  String get toi => 'Dark';

  @override
  String get caiDat => 'Config';

  @override
  String get mauSac => 'Color';

  @override
  String get ngonNgu => 'Language';

  @override
  String get nen => 'Theme';

  @override
  String get vaiTro => 'Role';

  @override
  String get zzz => '';
}
