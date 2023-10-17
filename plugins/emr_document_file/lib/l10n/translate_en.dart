import 'translate.dart';

/// The translations for English (`en`).
class TranslateEn extends Translate {
  TranslateEn([String locale = 'en']) : super(locale);

  @override
  String get fileVanBan => 'Text file';

  @override
  String get khongTimThayFileVanBan => 'Text file not found';

  @override
  String get ketThuc => 'Finish';

  @override
  String get ky => 'Sign';

  @override
  String get kyVaGhiChu => 'Sign & note';

  @override
  String get zzz => '';
}
