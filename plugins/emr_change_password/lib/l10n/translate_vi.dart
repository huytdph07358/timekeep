import 'translate.dart';

/// The translations for Vietnamese (`vi`).
class TranslateVi extends Translate {
  TranslateVi([String locale = 'vi']) : super(locale);

  @override
  String get duLieuBatBuoc => 'Dữ liệu bắt buộc';

  @override
  String get doiMatKhau => 'Đổi mật khẩu';

  @override
  String get matKhauHienTai => 'Mật khẩu hiện tại';

  @override
  String get matKhauMoi => 'Mật khẩu mới';

  @override
  String get nhapLaiMatKhauMoi => 'Nhập lại mật khẩu mới';

  @override
  String get khongKhopVoiMatKhauMoi => 'Không khớp với mật khẩu mới';

  @override
  String get dongY => 'Đồng ý';

  @override
  String get zzz => '';
}
