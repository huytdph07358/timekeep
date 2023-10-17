import 'translate.dart';

/// The translations for Vietnamese (`vi`).
class TranslateVi extends Translate {
  TranslateVi([String locale = 'vi']) : super(locale);

  @override
  String get chucNang => 'Chức năng';

  @override
  String get chucNangYeuThich => 'Chức năng yêu thích';

  @override
  String get themVaoYeuThich => 'Thêm vào yêu thích';

  @override
  String get longtext_chuThich => 'Luôn chỉ có 4 chức năng yêu thích. Việc thêm 1 chức năng mới sẽ đẩy 1 chức năng hiện có ra khỏi danh sách.';

  @override
  String get zzz => '';
}
