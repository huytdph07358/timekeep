import 'translate.dart';

/// The translations for Vietnamese (`vi`).
class TranslateVi extends Translate {
  TranslateVi([String locale = 'vi']) : super(locale);

  @override
  String get fileVanBan => 'File văn bản';

  @override
  String get khongTimThayFileVanBan => 'Không tìm thấy file văn bản';

  @override
  String get ketThuc => 'Kết thúc';

  @override
  String get ky => 'Ký';

  @override
  String get kyVaGhiChu => 'Ký & ghi chú';

  @override
  String get zzz => '';
}
