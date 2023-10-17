import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:emr_app_constant/app_constant.dart';
import 'package:emr_app_store/firebase_store.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_app_store/user_secure_storage.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/nms_uri.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_log/vss_log.dart';
import 'package:vss_theme/color_enum.dart';
import 'package:vss_theme/theme_store.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

import 'app_route.dart';
import 'app_route_observer.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  defaultToastGravityGlobal = ToastGravity.BOTTOM;
  final startTime = DateTime.now();
  await initialize(aLocaleLanguageList: LanguageStore.languageList());
  await initializeStartApp();

  // Khi build release cần comment dòng này
  //TODO:BUILD_ENV
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  await initializeFirebase();

  final finishTime = DateTime.now();
  final differenceTime = finishTime.difference(startTime).inSeconds;
  VssLog.push('Start app in $differenceTime s', ApiConsumer.applicationCode,
      ApiConsumer.appVersion,
      user: '...', screen: 'main');
  runApp(const Main());
}

Future<void> initializeStartApp() async {
  ApiConsumer.updateLanguage(LanguageStore.selectedLanguageCode);
  ApiConsumer.setApplicationCode(AppConstant.applicationCode);
  ApiConsumer.setUnAuthorizeCallback(unAuthorizeCallback);
  await LanguageStore.initializeLanguage();
  await ThemeStore.initializeTheme();
  await UserSecureStorage.init();
  await LoginStore.initTokenServerAndLocal();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  ApiConsumer.setVersion(packageInfo.version);
  VssLog.startTimer();
}

Future<void> unAuthorizeCallback() async {
  Get.snackbar('Thông báo - Notification',
      'Phiên làm việc của bạn đã hết, vui lòng đăng nhập lại để tiếp tục sử dụng - Your session has expired, please login again to continue using.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white);
  VssLog.push('UnAuthorizeCallback: Logout: Phiên làm việc của bạn đã hết',
      ApiConsumer.applicationCode, ApiConsumer.appVersion,
      user: LoginStore.acsTokenModel != null
          ? '${LoginStore.acsTokenModel?.User?.LoginName} - ${LoginStore.acsTokenModel?.User?.UserName}'
          : '...',
      screen: 'main');
  Navigator.of(getContext).pushNamedAndRemoveUntil(
      '/emr_login/LoginScreen', (Route<dynamic> route) => false);
}

Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    await initializeFirebaseMessage();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch (e) {
    log(e);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message: ${message.messageId}');
  if (message.notification != null) {
    log('Message also contained a notification: ${message.notification?.title}: ${message.notification?.body}');
    Get.snackbar(
        message.notification?.title ?? '', message.notification?.body ?? '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white);
  }
}

Future<void> initializeFirebaseMessage() async {
  final String? fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseStore.setTokenFirebase(value: fcmToken);
  // print(fcmToken);
  final Map<String, dynamic> body = {
    'ApiData': {
      'DeviceToken': fcmToken ?? '',
      'DeviceType': Platform.isIOS ? 'Ios' : 'Android',
      'ApplicationCode': AppConstant.applicationCode,
    }
  };
  final String uri =
      '${BackendDomain.nms}${NmsUri.api_NmsDeviceToken_RegisterWithoutLogin}';
  final ApiResultModel apiResultModel =
      await ApiConsumer.dotNetApi.post(uri, body: body);
  if (apiResultModel.Success) {
    //Foreground messages
    //To handle messages while your application is in the foreground, listen to the onMessage stream.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.snackbar(
            message.notification?.title ?? '', message.notification?.body ?? '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white);
      }
    });
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

enum UniLinksType { string, uri }

class _MainState extends State<Main> {
  ThemeMode themeMode = ThemeStore.getThemeMode;
  ColorEnum colorSelected = ColorEnum.orange;
  ThemeData currentThemeData = ThemeStore.getAppTheme();
  ThemeData currentDarkThemeData = ThemeStore.getAppDarkTheme();
  late TextTheme currentTextTheme;
  late Locale currentLocale = LanguageStore.localeSelected;

  String? _initialLink;
  Uri? _initialUri;
  String? _latestLink = 'Unknown';
  Uri? _latestUri;
  StreamSubscription? _sub;
  UniLinksType _type = UniLinksType.string;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }

  /// An implementation using a [String] link
  Future<void> initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    if (!kIsWeb) {
      _sub = linkStream.listen((String? link) {
        if (!mounted) {
          return;
        }
        setState(() {
          _latestLink = link ?? 'Unknown';
          _latestUri = null;
          try {
            if (link != null) _latestUri = Uri.parse(link);
          } on FormatException {}
        });
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        setState(() {
          _latestLink = 'Failed to get latest link: $err.';
          _latestUri = null;
        });
      });
    }

    // Attach a second listener to the stream
    if (!kIsWeb) {
      linkStream.listen((String? link) {
        log('got link: $link');
      }, onError: (Object err) {
        log('got err: $err');
      });
    }

    // Get the latest link
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _initialLink = await getInitialLink();
      log('initial link: $_initialLink');
      if (_initialLink != null) {
        _initialUri = await getInitialUri();
        handleOpenFromDeeplink();
      }
    } on PlatformException {
      _initialLink = 'Failed to get initial link.';
      _initialUri = null;
    } on FormatException {
      _initialLink = 'Failed to parse the initial link as Uri.';
      _initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _latestLink = _initialLink;
      _latestUri = _initialUri;
    });
  }

  /// An implementation using the [Uri] convenience helpers
  Future<void> initPlatformStateForUriUniLinks() async {
    // Attach a listener to the Uri links stream
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        setState(() {
          _latestUri = uri;
          _latestLink = uri?.toString() ?? 'Unknown';
        });
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        setState(() {
          _latestUri = null;
          _latestLink = 'Failed to get latest link: $err.';
        });
      });
    }

    // Attach a second listener to the stream
    if (!kIsWeb) {
      uriLinkStream.listen((Uri? uri) {
        log('got uri: ${uri?.path} ${uri?.queryParametersAll}');
      }, onError: (Object err) {
        log('got err: $err');
      });
    }

    // Get the latest Uri
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _initialUri = await getInitialUri();
      log('initial uri: ${_initialUri?.path}'
          ' ${_initialUri?.queryParametersAll}');
      _initialLink = _initialUri?.toString();
      if (_initialLink != null) {
        handleOpenFromDeeplink();
      }
    } on PlatformException {
      _initialUri = null;
      _initialLink = 'Failed to get initial uri.';
    } on FormatException {
      _initialUri = null;
      _initialLink = 'Bad parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _latestUri = _initialUri;
      _latestLink = _initialLink;
    });
  }

  void handleOpenFromDeeplink() {
    log('initial _Uri: $_initialUri');
    final String initialLinkDecode = Uri.decodeFull(_initialLink!);
    log('initial _initialLinkDecode: $initialLinkDecode');
    // final Uri uriWithParam = Uri.parse(Uri.decodeFull(_initialUri.toString()));
    // int option = 0;
    // String? appCode = '';
    // String? appScheme = '';
    // String? appHost = '';
    // String? appView = '';
    // uriWithParam.queryParameters.forEach((String key, String value) {
    //   if (key.contains('appView')) {
    //     appView = value;
    //   } else if (key.contains('option')) {
    //     option = int.parse(value);
    //   } else if (key.contains('appCode')) {
    //     appCode = value;
    //   } else if (key.contains('appScheme')) {
    //     appScheme = value;
    //   } else if (key.contains('appHost')) {
    //     appHost = value;
    //   }
    // });
    // if (appView != null && appView == 'vss_card_reader') {
    //   navigatorKey.currentState?.pushNamed('/vss_card_reader/CardReaderScreen',
    //       arguments: <String, dynamic>{
    //         'option': option,
    //         'appCode': appCode,
    //         'appScheme': appScheme,
    //         'appHost': appHost,
    //       });
    // }
  }

  void handleLocaleChange(int value) {
    final LanguageDataModel languageDataModel =
        LanguageStore.languageList()[value];
    final Locale locale = Locale(languageDataModel.languageCode!);
    LanguageStore.setLanguage(locale);
    Get.updateLocale(locale);
    setState(() {
      currentLocale = locale;
    });
  }

  void handleThemeDataChange(ThemeData themeData) {
    setState(() {
      currentThemeData = ThemeStore.getAppTheme();
      currentDarkThemeData = ThemeStore.getAppDarkTheme();
      themeMode = ThemeStore.getThemeMode;
    });
  }

  void handleColorSelect(int value) {
    ThemeStore.setThemeColor(value);
    setState(() {
      colorSelected = ThemeStore.colorSelected;
      currentThemeData = ThemeStore.getAppTheme();
      currentDarkThemeData = ThemeStore.getAppDarkTheme();
      currentTextTheme = Theme.of(context).textTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeStore.handleColorSelect = handleColorSelect;
    ThemeStore.handleThemeDataChange = handleThemeDataChange;
    LanguageStore.handleLocaleChange = handleLocaleChange;
    currentTextTheme = Theme.of(context).textTheme;

    final List<MapEntry<String, List<String>>>? queryParams =
        _latestUri?.queryParametersAll.entries.toList();
    // Linking.openURL(
    // `vcr://view?AppCode=TMA&Option=1&AppScheme=tma&AppHost=app`,
    // );

    log(queryParams);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bệnh án điện tử',
      navigatorKey: navigatorKey,
      scrollBehavior: SBehavior(),
      theme: currentThemeData,
      darkTheme: currentDarkThemeData,
      themeMode: themeMode,
      localizationsDelegates: const [
        // AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'), // Vietnamese
        Locale('en'), // English
      ],
      locale: currentLocale,
      navigatorObservers: [AppRouteObserver()],
      home: const SplashScreen(),
      // initialRoute: '/ConfigurationScreen',
      initialRoute: '/',
      getPages: AppRoute.initializeRoute(),
    );
  }
}
