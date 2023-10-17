import 'translate.dart';

/// The translations for English (`en`).
class TranslateEn extends Translate {
  TranslateEn([String locale = 'en']) : super(locale);

  @override
  String get tenDangNhap => 'Login name';

  @override
  String get duLieuBatBuoc => 'Require data';

  @override
  String get matKhau => 'Password';

  @override
  String get dangNhap => 'Login';

  @override
  String get phanMemDangTroVaoMoiTruongPhatTrien => 'The software is connecting to the develop environment';

  @override
  String get tongDaiHoTro => 'Call center';

  @override
  String get phienBan => 'Version';

  @override
  String get xacNhan => 'Confirm';

  @override
  String get banMuonTatPhanMem => 'Do you want to quit app?';

  @override
  String get dongY => 'Agree';

  @override
  String get boQua => 'Cancel';

  @override
  String get cauHinh => 'Config';

  @override
  String get maBenhVien => 'Hospital code';

  @override
  String get cauHinhHeThong => 'Config system';

  @override
  String get zzz => '';
}
