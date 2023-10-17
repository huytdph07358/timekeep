import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'translate_en.dart';
import 'translate_vi.dart';

/// Callers can lookup localized strings with an instance of Translate
/// returned by `Translate.of(context)`.
///
/// Applications need to include `Translate.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/translate.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Translate.localizationsDelegates,
///   supportedLocales: Translate.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Translate.supportedLocales
/// property.
abstract class Translate {
  Translate(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Translate of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate)!;
  }

  static const LocalizationsDelegate<Translate> delegate = _TranslateDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @danhSachVanBan.
  ///
  /// In en, this message translates to:
  /// **'Danh sách văn bản'**
  String get danhSachVanBan;

  /// No description provided for @benhAnDienTu.
  ///
  /// In en, this message translates to:
  /// **'Bệnh án điện tử'**
  String get benhAnDienTu;

  /// No description provided for @banCoChacChanMuonHuyVanBan.
  ///
  /// In en, this message translates to:
  /// **'Bạn có chắc chắn muốn hủy văn bản?'**
  String get banCoChacChanMuonHuyVanBan;

  /// No description provided for @choKy.
  ///
  /// In en, this message translates to:
  /// **'Chờ ký'**
  String get choKy;

  /// No description provided for @daKy.
  ///
  /// In en, this message translates to:
  /// **'Đã ký'**
  String get daKy;

  /// No description provided for @toiTao.
  ///
  /// In en, this message translates to:
  /// **'Tôi tạo'**
  String get toiTao;

  /// No description provided for @toiHuy.
  ///
  /// In en, this message translates to:
  /// **'Tôi huỷ'**
  String get toiHuy;

  /// No description provided for @tuChoi.
  ///
  /// In en, this message translates to:
  /// **'Từ chối'**
  String get tuChoi;

  /// No description provided for @lamLai.
  ///
  /// In en, this message translates to:
  /// **'Làm lại'**
  String get lamLai;

  /// No description provided for @dieuKienLoc.
  ///
  /// In en, this message translates to:
  /// **'Điều kiện lọc'**
  String get dieuKienLoc;

  /// No description provided for @loaiVanBan.
  ///
  /// In en, this message translates to:
  /// **'Loại văn bản'**
  String get loaiVanBan;

  /// No description provided for @sapXepTheo.
  ///
  /// In en, this message translates to:
  /// **'Sắp xếp theo'**
  String get sapXepTheo;

  /// No description provided for @hoSo.
  ///
  /// In en, this message translates to:
  /// **'Hồ sơ'**
  String get hoSo;

  /// No description provided for @thongBao.
  ///
  /// In en, this message translates to:
  /// **'Thông báo'**
  String get thongBao;

  /// No description provided for @caiDat.
  ///
  /// In en, this message translates to:
  /// **'Cài đặt'**
  String get caiDat;

  /// No description provided for @banMuonDangXuat.
  ///
  /// In en, this message translates to:
  /// **'Bạn muốn đăng xuất?'**
  String get banMuonDangXuat;

  /// No description provided for @phienBan.
  ///
  /// In en, this message translates to:
  /// **'Phiên bản'**
  String get phienBan;

  /// No description provided for @dienThoai.
  ///
  /// In en, this message translates to:
  /// **'Điện thoại'**
  String get dienThoai;

  /// No description provided for @dinhDanh.
  ///
  /// In en, this message translates to:
  /// **'Định danh'**
  String get dinhDanh;

  /// No description provided for @dongY.
  ///
  /// In en, this message translates to:
  /// **'Đồng ý'**
  String get dongY;

  /// No description provided for @doiMatKhau.
  ///
  /// In en, this message translates to:
  /// **'Đổi mật khẩu'**
  String get doiMatKhau;

  /// No description provided for @banMuonTatPhanMem.
  ///
  /// In en, this message translates to:
  /// **'Bạn muốn tắt phần mềm?'**
  String get banMuonTatPhanMem;

  /// No description provided for @phanHoi.
  ///
  /// In en, this message translates to:
  /// **'Phản hồi'**
  String get phanHoi;

  /// No description provided for @khongCoVanBan.
  ///
  /// In en, this message translates to:
  /// **'Không có văn bản'**
  String get khongCoVanBan;

  /// No description provided for @chiTietVanBan.
  ///
  /// In en, this message translates to:
  /// **'Chi tiết văn bản'**
  String get chiTietVanBan;

  /// No description provided for @tu.
  ///
  /// In en, this message translates to:
  /// **'Từ'**
  String get tu;

  /// No description provided for @den.
  ///
  /// In en, this message translates to:
  /// **'Đến'**
  String get den;

  /// No description provided for @dangXuat.
  ///
  /// In en, this message translates to:
  /// **'Đăng xuất'**
  String get dangXuat;

  /// No description provided for @timKiem.
  ///
  /// In en, this message translates to:
  /// **'Tìm Kiếm'**
  String get timKiem;

  /// No description provided for @thoiGianTrinhKy.
  ///
  /// In en, this message translates to:
  /// **'Thời gian trình ký'**
  String get thoiGianTrinhKy;

  /// No description provided for @thoiGianHuy.
  ///
  /// In en, this message translates to:
  /// **'Thời gian huỷ'**
  String get thoiGianHuy;

  /// No description provided for @kiemTra.
  ///
  /// In en, this message translates to:
  /// **'Kiểm tra'**
  String get kiemTra;

  /// No description provided for @thoiGian.
  ///
  /// In en, this message translates to:
  /// **'Thời gian'**
  String get thoiGian;

  /// No description provided for @thoiGianLoc.
  ///
  /// In en, this message translates to:
  /// **'Thời gian lọc'**
  String get thoiGianLoc;

  /// No description provided for @ketThuc.
  ///
  /// In en, this message translates to:
  /// **'Kết thúc'**
  String get ketThuc;

  /// No description provided for @batDau.
  ///
  /// In en, this message translates to:
  /// **'Bắt đầu'**
  String get batDau;

  /// No description provided for @gio.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get gio;

  /// No description provided for @boQua.
  ///
  /// In en, this message translates to:
  /// **'Bỏ qua'**
  String get boQua;

  /// No description provided for @xacNhan.
  ///
  /// In en, this message translates to:
  /// **'Xác nhận'**
  String get xacNhan;

  /// No description provided for @lyDoPhoBien.
  ///
  /// In en, this message translates to:
  /// **'Lý do phổ biến'**
  String get lyDoPhoBien;

  /// No description provided for @lyDo.
  ///
  /// In en, this message translates to:
  /// **'Lý do'**
  String get lyDo;

  /// No description provided for @vidu.
  ///
  /// In en, this message translates to:
  /// **'Ví dụ: loại văn bản, tên văn bản ...'**
  String get vidu;

  /// No description provided for @duLieuBatBuoc.
  ///
  /// In en, this message translates to:
  /// **'Dữ liệu bắt buộc'**
  String get duLieuBatBuoc;

  /// No description provided for @xuLyThanhCong.
  ///
  /// In en, this message translates to:
  /// **'Xử lý thành công'**
  String get xuLyThanhCong;

  /// No description provided for @hoTen.
  ///
  /// In en, this message translates to:
  /// **'Họ và tên'**
  String get hoTen;

  /// No description provided for @ngaySinh.
  ///
  /// In en, this message translates to:
  /// **'Ngày sinh'**
  String get ngaySinh;

  /// No description provided for @khongHopLe.
  ///
  /// In en, this message translates to:
  /// **'Báo cáo vi phạm'**
  String get khongHopLe;

  /// No description provided for @lyDoKhac.
  ///
  /// In en, this message translates to:
  /// **'Lý do khác'**
  String get lyDoKhac;

  /// No description provided for @zzz.
  ///
  /// In en, this message translates to:
  /// **''**
  String get zzz;
}

class _TranslateDelegate extends LocalizationsDelegate<Translate> {
  const _TranslateDelegate();

  @override
  Future<Translate> load(Locale locale) {
    return SynchronousFuture<Translate>(lookupTranslate(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_TranslateDelegate old) => false;
}

Translate lookupTranslate(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return TranslateEn();
    case 'vi': return TranslateVi();
  }

  throw FlutterError(
    'Translate.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
