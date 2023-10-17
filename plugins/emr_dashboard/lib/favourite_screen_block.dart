import 'package:flutter/material.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_locale/language_store.dart';
import 'package:emr_app_store/model/tvb_screen_model.dart';
import 'package:emr_screen/favourite_screen_store.dart';

class FavouriteScreenBlock extends StatefulWidget {
  const FavouriteScreenBlock({super.key});

  @override
  State<FavouriteScreenBlock> createState() => _FavouriteScreenBlockState();
}

class _FavouriteScreenBlockState extends State<FavouriteScreenBlock> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        initialData: FavouriteScreenStore.getFavouriteScreenLinkList(),
        stream: FavouriteScreenStore.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final List<TvbScreenModel> module =
                FavouriteScreenStore.screenLinkToScreen(snapshot.data);

            return SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: module.map(screenWidget).toList(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget screenWidget(TvbScreenModel screen) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final int icon = screen.icon != null ? screen.icon! : 62617;
    final String screenName = (screen.names != null &&
            screen.names!
                .containsKey(LanguageStore.localeSelected.languageCode))
        ? screen.names![LanguageStore.localeSelected.languageCode]!
        : screen.screenName!;

    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4.5,
        child: Container(
          padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength / 2),
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
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, screen.screenLink!);
      },
    );
  }
}
