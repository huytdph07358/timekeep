import 'package:flutter/material.dart';
import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:emr_app_store/model/tvb_screen_model.dart';
import 'package:emr_app_store/screen_store.dart';
import 'package:emr_authorize/role_store.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_locale/language_store.dart';

import 'favourite_screen_store.dart';
import 'l10n/translate.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  final String screenLink = '/vss_screen/AllScreen';
  final Translate translate = lookupTranslate(LanguageStore.localeSelected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmrAppBar(
        title: translate.chucNang,
        showHome: false,
        screenLink: screenLink,
      ),
      body: Container(
        padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
        child: buildGridView(),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: GlobalConstant.paddingMarginLength,
      childAspectRatio: 0.6,
      children: getMenu(),
    );
  }

  List<Widget> getMenu() {
    final List<TvbScreenModel> allMenu = ScreenStore.getAllMenu();
    final List<TvbScreenModel> result = <TvbScreenModel>[];
    for (int i = 0; i < allMenu.length; i++) {
      if (allMenu[i].roles?.isNotEmpty ?? false) {
        for (final String role in allMenu[i].roles!) {
          if (RoleStore.roleCodeList.contains(role)) {
            result.add(allMenu[i]);
            break;
          }
        }
      } else {
        result.add(allMenu[i]);
      }
    }
    return result.map(screen).toList();
  }

  Widget screen(TvbScreenModel screen) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final int icon = screen.icon != null ? screen.icon! : 62617;
    final String screenName = (screen.names != null &&
            screen.names!
                .containsKey(LanguageStore.localeSelected.languageCode))
        ? screen.names![LanguageStore.localeSelected.languageCode]!
        : screen.screenName!;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, screen.screenLink!);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return bottomSheet(screen.screenLink!);
          },
        );
      },
      child: Column(children: <Widget>[
        Icon(
          IconData(icon, fontFamily: 'MaterialIcons'),
          size: 35,
        ),
        GlobalConstant.colDivider,
        Text(
          screenName,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
      ]),
    );
  }

  Widget bottomSheet(String selectScreenLink) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);

    final List<TvbScreenModel> favouriteScreen =
        FavouriteScreenStore.getFavouriteScreen();

    return Container(
      height: 350,
      // TODO(team): nghiên cứu vấn đề độ cao động trong các trường hợp dùng grid - hoặc giải pháp khác tương đương thay thế
      padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
      child: Column(
        children: <Widget>[
          Text(
            translate.chucNangYeuThich,
            style: textTheme.titleLarge!.copyWith(
              color: colorScheme.primary,
            ),
          ),
          GlobalConstant.colDivider,
          GlobalConstant.colDivider,
          GlobalConstant.colDivider,
          Expanded(
            child: StreamBuilder<List<String>>(
                stream: FavouriteScreenStore.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    final List<TvbScreenModel> screenModelList =
                        FavouriteScreenStore.screenLinkToScreen(snapshot.data);
                    return GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: GlobalConstant.paddingMarginLength,
                      childAspectRatio: 0.6,
                      children: screenModelList.map(screen).toList(),
                    );
                  } else {
                    return GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: GlobalConstant.paddingMarginLength,
                      childAspectRatio: 0.6,
                      children: favouriteScreen.map(screen).toList(),
                    );
                  }
                }),
          ),
          GlobalConstant.colDivider,
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                FavouriteScreenStore.addFavouriteScreenLink(selectScreenLink);
              },
              child: Text(translate.themVaoYeuThich),
            ),
          ),
          GlobalConstant.colDivider,
          Text(
            translate.longtext_chuThich,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall!.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
