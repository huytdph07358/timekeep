import 'translate.dart';

/// The translations for Vietnamese (`vi`).
class TranslateVi extends Translate {
  TranslateVi([String locale = 'vi']) : super(locale);

  @override
  String get longtext_baoTriChucNang => 'Chức năng đang được bảo trì. Vui lòng quay lại sau. Rất mong quý khách thông cảm cho sự gián đoạn này.';

  @override
  String get zzz => '';
}
