import 'translate.dart';

/// The translations for English (`en`).
class TranslateEn extends Translate {
  TranslateEn([String locale = 'en']) : super(locale);

  @override
  String get chucNang => 'Screen';

  @override
  String get chucNangYeuThich => 'Favourite screen';

  @override
  String get themVaoYeuThich => 'Add to favourite';

  @override
  String get longtext_chuThich => 'Luôn chỉ có 4 chức năng yêu thích. Việc thêm 1 chức năng mới sẽ đẩy 1 chức năng hiện có ra khỏi danh sách.';

  @override
  String get zzz => '';
}
