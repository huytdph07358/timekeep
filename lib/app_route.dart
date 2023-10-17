import 'package:emr_login/configuration_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/route_manager.dart';
import 'package:emr_change_password/change_password_screen.dart';
import 'package:emr_config/config_screen.dart';
import 'package:emr_dashboard/dashboard_screen.dart';
import 'package:emr_environment_chooser/environment_chooser_screen.dart';
import 'package:emr_login/login_screen.dart';
import 'package:emr_login/configuration_screen.dart';
import 'package:emr_screen/all_screen.dart';
import 'package:emr_document/document_screen.dart';
import 'package:emr_document_file/document_file_screen.dart';
import 'package:emr_document_detail/document_detail_screen.dart';

class AppRoute {
  static List<GetPage<dynamic>> initializeRoute() {
    return [
      GetPage(
        name: '/',
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/#/',
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/emr_login/ConfigurationScreen',
        page: () => const ConfigurationScreen(),
      ),
      GetPage(
        name: '/emr_login/LoginScreen',
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/emr_screen/AllScreen',
        page: () => const AllScreen(),
      ),
      GetPage(
        name: '/emr_change_password/ChangePasswordScreen',
        page: () => const ChangePasswordScreen(),
      ),
      GetPage(
        name: '/emr_config/ConfigScreen',
        page: () => const ConfigScreen(),
      ),
      GetPage(
        name: '/emr_environment_chooser/EnvironmentChooserScreen',
        page: () => const EnvironmentChooserScreen(),
      ),
      GetPage(
        name: '/emr_dashboard/DashboardScreen',
        page: () => const DashboardScreen(),
      ),
      GetPage(
        name: '/emr_document_file/DocumentFileScreen',
        page: () => DocumentFileScreen(),
      ),
      GetPage(
        name: '/emr_document_detail/DocumentDetailScreen',
        page: () => DocumentDetailScreen(),
      ),
      GetPage(
        name: '/emr_document/DocumentScreen',
        page: () => DocumentScreen(),
      ),
    ];
  }
}
