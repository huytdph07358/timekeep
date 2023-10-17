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

  /// No description provided for @thanhCong.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get thanhCong;

  /// No description provided for @thatBai.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get thatBai;

  /// No description provided for @veDaBan.
  ///
  /// In en, this message translates to:
  /// **'Tickets Sold'**
  String get veDaBan;

  /// No description provided for @soDoGhe.
  ///
  /// In en, this message translates to:
  /// **'Seat diagram'**
  String get soDoGhe;

  /// No description provided for @tienMat.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get tienMat;

  /// No description provided for @qrthe.
  ///
  /// In en, this message translates to:
  /// **'QR card'**
  String get qrthe;

  /// No description provided for @soTien.
  ///
  /// In en, this message translates to:
  /// **'Into money'**
  String get soTien;

  /// No description provided for @soGhe.
  ///
  /// In en, this message translates to:
  /// **'Number of seats'**
  String get soGhe;

  /// No description provided for @chonGheMua.
  ///
  /// In en, this message translates to:
  /// **'Choose a chair to buy'**
  String get chonGheMua;

  /// No description provided for @doiTuong.
  ///
  /// In en, this message translates to:
  /// **'Ticket Type'**
  String get doiTuong;

  /// No description provided for @chonGhe.
  ///
  /// In en, this message translates to:
  /// **'Select a chair'**
  String get chonGhe;

  /// No description provided for @huy.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get huy;

  /// No description provided for @chon.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get chon;

  /// No description provided for @banVe.
  ///
  /// In en, this message translates to:
  /// **'Ticket sales'**
  String get banVe;

  /// No description provided for @banChuaMuaVeNao.
  ///
  /// In en, this message translates to:
  /// **'You have not bought any tickets yet'**
  String get banChuaMuaVeNao;

  /// No description provided for @dangCapNhat.
  ///
  /// In en, this message translates to:
  /// **'Updating'**
  String get dangCapNhat;

  /// No description provided for @giaVe.
  ///
  /// In en, this message translates to:
  /// **'Ticket price'**
  String get giaVe;

  /// No description provided for @chiTietVanBan.
  ///
  /// In en, this message translates to:
  /// **'Document details'**
  String get chiTietVanBan;

  /// No description provided for @daBan.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get daBan;

  /// No description provided for @choCon.
  ///
  /// In en, this message translates to:
  /// **'Space left'**
  String get choCon;

  /// No description provided for @dangChon.
  ///
  /// In en, this message translates to:
  /// **'Statue of Liberty'**
  String get dangChon;

  /// No description provided for @inVe.
  ///
  /// In en, this message translates to:
  /// **'Print the next ticket'**
  String get inVe;

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
