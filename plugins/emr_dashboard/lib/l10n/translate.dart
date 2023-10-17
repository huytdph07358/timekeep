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

  /// No description provided for @veXe.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get veXe;

  /// No description provided for @theViet.
  ///
  /// In en, this message translates to:
  /// **'The Viet'**
  String get theViet;

  /// No description provided for @hoSo.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get hoSo;

  /// No description provided for @thongBao.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get thongBao;

  /// No description provided for @caiDat.
  ///
  /// In en, this message translates to:
  /// **'Config'**
  String get caiDat;

  /// No description provided for @dangXuat.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get dangXuat;

  /// No description provided for @xacNhan.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get xacNhan;

  /// No description provided for @banMuonDangXuat.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout?'**
  String get banMuonDangXuat;

  /// No description provided for @boQua.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get boQua;

  /// No description provided for @phienBan.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get phienBan;

  /// No description provided for @dienThoai.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get dienThoai;

  /// No description provided for @dinhDanh.
  ///
  /// In en, this message translates to:
  /// **'Identify'**
  String get dinhDanh;

  /// No description provided for @dongY.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get dongY;

  /// No description provided for @doiMatKhau.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get doiMatKhau;

  /// No description provided for @banMuonTatPhanMem.
  ///
  /// In en, this message translates to:
  /// **'Do you want to quit app?'**
  String get banMuonTatPhanMem;

  /// No description provided for @moTheChoToi.
  ///
  /// In en, this message translates to:
  /// **'Issue card for me'**
  String get moTheChoToi;

  /// No description provided for @phanHoi.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get phanHoi;

  /// No description provided for @benhAnDienTu.
  ///
  /// In en, this message translates to:
  /// **'Bệnh án điện tử'**
  String get benhAnDienTu;

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

  /// No description provided for @longtext_DeNghiMoThe.
  ///
  /// In en, this message translates to:
  /// **'Your account needs to open a card to be able to use the features provided by The Viet such as payment, points accumulation, e-tickets, contact management...'**
  String get longtext_DeNghiMoThe;

  /// No description provided for @appName_DuLichVietNam.
  ///
  /// In en, this message translates to:
  /// **'Vietnam Travel-Du lich Vietnam'**
  String get appName_DuLichVietNam;

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
