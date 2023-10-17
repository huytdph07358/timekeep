import 'translate.dart';

/// The translations for English (`en`).
class TranslateEn extends Translate {
  TranslateEn([String locale = 'en']) : super(locale);

  @override
  String get duLieuBatBuoc => 'Require data';

  @override
  String get doiMatKhau => 'Change password';

  @override
  String get matKhauHienTai => 'Current password';

  @override
  String get matKhauMoi => 'New password';

  @override
  String get nhapLaiMatKhauMoi => 'Confirm new password';

  @override
  String get khongKhopVoiMatKhauMoi => 'Not match new password';

  @override
  String get dongY => 'Agree';

  @override
  String get zzz => '';
}
