import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_authorize/role_store.dart';
import 'package:upgrader/upgrader.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:emr_app_store/user_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    init();
  }

  bool onIgnore() {
    checkAndRoute();
    return true;
  }

  bool onLater() {
    checkAndRoute();
    return true;
  }

  bool onUpdate() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
    return true;
  }

  Future<void> init() async {
    checkAndRoute(); //TODO tạm bỏ upgrate từ store vì cài app trên pos không có app store
    // Upgrader upgrader = Upgrader();
    // await upgrader.initialize();
    // if (upgrader.isUpdateAvailable()) {
    //   int? major, minor, patch;
    //   final List<String> parts = upgrader.currentAppStoreVersion()!.split(".");
    //   major = int.parse(parts[0]);
    //   if (parts.length > 1) {
    //     minor = int.parse(parts[1]);
    //     if (parts.length > 2) {
    //       patch = int.parse(parts[2]);
    //     }
    //   }
    //   //Neu thoa man theo quy tac major version thi cần ẩn các nút bỏ qua và đồng ý đi, bắt người dùng phải cập nhật
    //   upgrader = Upgrader(
    //     debugLogging: true,
    //     debugDisplayAlways: true,
    //     onIgnore: onIgnore,
    //     onLater: onLater,
    //     onUpdate: onUpdate,
    //     showIgnore: patch != 0,
    //     showLater: patch != 0,
    //   );
    //   await upgrader.initialize();
    //
    //   upgrader.checkVersion(context: context);
    // } else {
    //   if (mounted) {
    //     finish(context);
    //   }
    //   checkAndRoute();
    // }
  }

//TODO phuongdt comment sửa lại sau
  void checkAndRoute() {
    if (LoginStore.acsTokenModel != null &&
        UserSecureStorage.getConfigModel() != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context,
            '/emr_dashboard/DashboardScreen', (Route<dynamic> route) => false);
      });

      // Future.wait([RoleStore.checkRole(), ScreenStore.getAllScreen()])
      //     .then((List<void> value) {

      // });
    } else {
      if (UserSecureStorage.getConfigModel() != null) {
        Future.delayed(Duration.zero, () {
          Navigator.pushNamedAndRemoveUntil(context, '/emr_login/LoginScreen',
              (Route<dynamic> route) => false);
        });
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pushNamedAndRemoveUntil(
              context,
              '/emr_login/ConfigurationScreen',
              (Route<dynamic> route) => false);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: const Center(),
      ),
    );
  }
}
