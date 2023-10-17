import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:emr_document/document_canceled_screen.dart';
import 'package:emr_document/document_signing_screen.dart';
import 'package:emr_document/document_rejected_screen.dart';
import 'package:emr_document/document_signed_screen.dart';
import 'package:emr_document/document_creator_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vss_locale/language_store.dart';
import 'package:emr_app_store/tab_store.dart';

import 'l10n/translate.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  final List<Widget> dashboardPage = <Widget>[
    DocumentSigningScreen(option: 'signing'),
    DocumentRejectedScreen(option: 'rejected'),
    DocumentSignedScreen(option: 'signed'),
    DocumentCreatorScreen(option: 'creator'),
    DocumentCanceledScreen(option: 'canceled'),
  ];

  @override
  void initState() {
    super.initState();
    TabStore.currentTabIndex = 0;
    TabStore.nextTabIndex = 0;
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
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);

    return WillPopScope(
      onWillPop: () async {
        bool? isChoiseQuit = await confirmQuit();
        return isChoiseQuit ?? false;
      },
      child: Scaffold(
        body: dashboardPage.elementAt(selectedIndex),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: colorScheme.primary,
            color: colorScheme.onPrimary,
            style: TabStyle.react,
            items: const <TabItem<dynamic>>[
              TabItem(icon: Icons.watch_later_outlined, title: 'Chờ ký'),
              TabItem(icon: Icons.design_services_outlined, title: 'Từ chối'),
              TabItem(icon: Icons.fact_check_outlined, title: 'Đã ký'),
              TabItem(icon: Icons.person_add_alt_1, title: 'Tôi tạo'),
              TabItem(icon: Icons.person_remove_outlined, title: 'Tôi hủy'),
            ],
            initialActiveIndex: 0,
            onTap: (int i) {
              TabStore.currentTabIndex = TabStore.nextTabIndex;
              TabStore.nextTabIndex = i;
              setState(() {
                selectedIndex = i;
              });
            }),
      ),
    );
  }

  Future<bool> confirmQuit() async {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              translate.xacNhan,
            ),
            content: Text(
              translate.banMuonTatPhanMem,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  finish(context);
                },
                child: Text(
                  translate.boQua,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  translate.dongY,
                ),
              )
            ],
          );
        });
  }
}
