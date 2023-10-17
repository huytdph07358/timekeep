import 'translate.dart';

/// The translations for Vietnamese (`vi`).
class TranslateVi extends Translate {
  TranslateVi([String locale = 'vi']) : super(locale);

  @override
  String get longtext_khongCoVaiTroTiketSeller => 'Bạn chưa được khai báo là nhân viên bán vé xe buýt';

  @override
  String get longtext_khongCoVaiTroSupervisor => 'Bạn cần được phân vai trò giám sát viên để có thể sử dụng tính năng này';

  @override
  String get longtext_khongCoVaiTroRegister => 'Bạn cần được phân vai trò đăng ký thiết bị để có thể sử dụng tính năng này';

  @override
  String get longtext_khongCoVaiTroTester => 'Bạn cần được phân vai trò kiểm thử viên để có thể sử dụng tính năng này';

  @override
  String get zzz => '';
}
