import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_environment/environment_enum.dart';
import 'package:vss_environment/environment_switch.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_log/vss_log.dart';
import 'package:vss_navigator/navigator.dart';
import 'package:vss_theme/theme_store.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:emr_uri/acs_uri.dart';
import 'package:emr_backend_domain/backend_domain.dart';

import 'component/FilteredResultComponent.dart';
import 'component/clear_button.dart';
import 'date_constans.dart';
import 'filtered_screen.dart';
import 'l10n/translate.dart';
import 'model/emr_document_model.dart';
import 'model/filter_model.dart';

class DocumentScreen extends StatefulWidget {
  DocumentScreen({super.key, this.option = 'signing'});

  String option = 'signing';

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  String? tripCode;
  final Translate translate = lookupTranslate(LanguageStore.localeSelected);
  final DateFormat dateFormatFull =
      DateFormat.yMd(LanguageStore.localeSelected.languageCode).add_Hm();
  final DateFormat dateFormat =
      DateFormat.yMd(LanguageStore.localeSelected.languageCode);
  Map<String, List<EmrDocumentModel>> mapDataAll = {};
  Map<String, int> mapStartPageAll = {};
  List<EmrDocumentModel>? resultDataAll;
  AsyncMemoizer<List<EmrDocumentModel>?> documentListMemoizer =
      AsyncMemoizer<List<EmrDocumentModel>?>();
  final ScrollController controller = ScrollController();
  bool isloading = false;
  bool ismaxScrollExtentState = false;
  bool hasMore = true;
  int limitPage = 10;
  int pageNumMax = 0;
  int currentPageNum = 0;
  int countNum = 0;
  bool formSubmitting = false;
  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);
  String version = '';
  TextEditingController controllerDocumentFilter = TextEditingController();
  double textFieldHeight = 50.0;
  FocusNode keywordFocus = FocusNode();
  String? daysValue = DateConstans.motThang;
  FilterModel filterModel = FilterModel();

  @override
  void initState() {
    super.initState();
    filterModel = FilterModel()
      ..totalDays = daysValue
      ..documentTypeId = null
      ..documentTypeName = null;

    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (currentPageNum < pageNumMax - 1) {
          currentPageNum++;
          await getDocument(ismaxScrollExtent: true);

          controller.animateTo(controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut);
        }
      }
    });

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controllerDocumentFilter.dispose();
    super.dispose();
  }

  Widget buildDrawer() {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          InkWell(
            onTap: () {
              //Navigator.pushNamed(context, '/emr_profile/DetailProfileScreen');//TODO
            },
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: avatar(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(translate.caiDat),
            onTap: () {
              Navigator.pushNamed(context, '/emr_config/ConfigScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: Text(translate.doiMatKhau),
            onTap: () {
              Navigator.pushNamed(
                  context, '/emr_change_password/ChangePasswordScreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(translate.dangXuat),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        translate.xacNhan,
                      ),
                      content: Text(
                        translate.banMuonDangXuat,
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
                        ValueListenableBuilder<bool>(
                            valueListenable: submitNotifier,
                            builder: (BuildContext context, bool val,
                                Widget? child) {
                              return TextButton(
                                onPressed: () {
                                  if (formSubmitting) {
                                    return;
                                  }
                                  formSubmitting = true;
                                  submitNotifier.value = true;

                                  ApiConsumer.dotNetApi
                                      .post(
                                          '${BackendDomain.acs}${AcsUri.api_Token_Logout}')
                                      .then((ApiResultModel apiResultModel) {
                                    finish(context);
                                    LoginStore.deleteToken();
                                    VssLog.push(
                                        'Logout',
                                        ApiConsumer.applicationCode,
                                        ApiConsumer.appVersion,
                                        user: LoginStore.acsTokenModel != null
                                            ? '${LoginStore.acsTokenModel?.User?.LoginName} - ${LoginStore.acsTokenModel?.User?.UserName}'
                                            : '...',
                                        screen: 'HomeScreen',
                                        module: '/');
                                    formSubmitting = false;
                                    submitNotifier.value = false;
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/emr_login/LoginScreen',
                                            (Route<dynamic> route) => false);
                                  });
                                },
                                child: !formSubmitting
                                    ? Text(translate.dongY)
                                    : const CircularProgressIndicator(),
                              );
                            }),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: Text(
                '${translate.phienBan}: $version${EnvironmentSwitch.environment == EnvironmentEnum.dev.env ? '-dev' : ''}'),
          ),
        ],
      ),
    );
  }

  Widget avatar() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                overflow: TextOverflow.ellipsis,
                LoginStore.acsTokenModel?.User?.UserName ?? '',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                LoginStore.acsTokenModel?.User?.LoginName ?? '',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration boxDecoration(
      {double radius = 2,
      Color color = Colors.transparent,
      Color? bgColor,
      var showShadow = false}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: bgColor ?? colorScheme.background,
      boxShadow: showShadow
          ? defaultBoxShadow(shadowColor: shadowColorGlobal)
          : [const BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  Widget filteredWidget(
      {Widget? widget, double vertical = 8, double horizontal = 16}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(8),
        backgroundColor: ThemeStore.isDarkModeOn
            ? scaffoldDarkColor
            : colorScheme.background,
      ),
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {}
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          title: Text(
            '${translate.benhAnDienTu}',
            style: TextStyle(
              color: colorScheme.onPrimary,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: colorScheme.onPrimary),
        ),
        drawer: buildDrawer(),
        body: GestureDetector(
            onVerticalDragEnd: (DragEndDetails details) {
              if ((details.primaryVelocity ?? 0) > 0) {
                // User swiped down
                currentPageNum = 0;
                pageNumMax = 0;
                mapDataAll = Map<String, List<EmrDocumentModel>>();
                mapStartPageAll = Map<String, int>();
                setState(() {});
              } else if ((details.primaryVelocity ?? 0) < 0) {
                // User swiped Right
              }
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildTextFilterContainer(colorScheme),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Row(
                  children: [
                    filteredWidget(
                            widget: const Icon(Icons.filter_list, size: 18))
                        .cornerRadiusWithClipRRect(8)
                        .onTap(() async {
                      final FilterModel? filterModelModify =
                          await popUpPage<FilterModel>(
                        FilteredScreen(
                          filterModel: filterModel,
                        ),
                        context,
                      );
                      if (filterModelModify != null) {
                        filterModel = filterModelModify;
                        daysValue = filterModelModify.totalDays;
                        currentPageNum = 0;
                        mapDataAll = Map<String, List<EmrDocumentModel>>();
                        mapStartPageAll = Map<String, int>();
                        setState(() {});
                      }
                    }),
                    8.width,
                    Text('${translate.thoiGianLoc}: ',
                        style: primaryTextStyle(size: 16)),
                    4.height,
                    filteredWidget(
                        widget: buildChooseDayDropdownButton(context),
                        horizontal: 8,
                        vertical: 0),
                  ],
                ),
              ),
              4.height,
              if ((daysValue == DateConstans.tuyChon &&
                      filterModel.fromDate != null &&
                      filterModel.toDate != null) ||
                  filterModel.documentTypeName != null)
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          '${translate.dieuKienLoc}: ${(daysValue == DateConstans.tuyChon && filterModel.fromDate != null && filterModel.toDate != null) ? ('${translate.thoiGian}: ${dateFormat.format(filterModel.fromDate!)} - ${dateFormat.format(filterModel.toDate!)}') : ''}${filterModel.documentTypeName != null ? ' ${translate.loaiVanBan}: ${filterModel.documentTypeName}' : ''}',
                          style: primaryTextStyle(size: 14),
                          maxLines: 4,
                        )
                        // Text(
                        //     "${(currentPageNum * limitPage) + 1} - ${(currentPageNum * limitPage) + limitPage} / ${countNum}",
                        //     style: secondaryTextStyle()),
                      ],
                    ).paddingOnly(left: 16))
              else
                const SizedBox.shrink(),
              FutureBuilder<List<EmrDocumentModel>?>(
                future: getDocument(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<EmrDocumentModel>?> snapshot) {
                  Widget child;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    child = const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    child = Text(
                      snapshot.error.toString(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      child = ListView.builder(
                        controller: controller,
                        itemCount: snapshot.data!.length + 1,
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < snapshot.data!.length) {
                            final EmrDocumentModel data = snapshot.data![index];
                            return FilteredResultComponent(
                                filteredResultsList: data,
                                index: index,
                                option: widget.option,
                                onDocumentProcessCallback:
                                    (bool success) async {
                                  if (success) {
                                    setState(() {});
                                  }
                                });
                          } else {
                            return child = isloading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const SizedBox();
                          }
                        },
                      ).expand();
                    } else {
                      child = Center(
                        child: Text(translate.khongCoVanBan), //TODO
                      );
                    }
                  } else {
                    child = const Center(child: CircularProgressIndicator());
                  }
                  return child;
                },
              ),
            ])));
  }

  Container buildTextFilterContainer(ColorScheme colorScheme) {
    return Container(
      height: textFieldHeight,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
      decoration: boxDecoration(
          radius: 8,
          color: ThemeStore.isDarkModeOn ? scaffoldDarkColor : white),
      child: TextFormField(
          controller: controllerDocumentFilter,
          autofocus: false,
          onChanged: searchDocumentChange,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: gray.withOpacity(0.4)),
            ),
            hintStyle: secondaryTextStyle(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: gray.withOpacity(0.4)),
            ),
            // filled: true,
            suffixIcon: controllerDocumentFilter.text.isEmpty
                ? Container(
                    width: 0,
                  )
                : ClearButton(controller: controllerDocumentFilter),
            prefixIcon: Icon(Icons.search),
            hintText: translate.vidu,
          )),
    );
  }

  DropdownButton<String> buildChooseDayDropdownButton(BuildContext context) {
    return DropdownButton(
      isExpanded: false,
      underline: Container(color: Colors.transparent),
      value: daysValue,
      icon: const Icon(Icons.arrow_drop_down),
      items: DateConstans.daysItems.map((String daysItems) {
        return DropdownMenuItem(
          value: daysItems,
          child: Text(daysItems, style: primaryTextStyle(size: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) async {
        if (newValue == DateConstans.tuyChon) {
          filterModel.totalDays = newValue;
          final FilterModel? filterModelModify = await popUpPage<FilterModel>(
            FilteredScreen(
              filterModel: filterModel,
            ),
            context,
          );

          if (filterModelModify != null) {
            filterModel = filterModelModify;
            daysValue = filterModelModify.totalDays;
            currentPageNum = 0;
            mapDataAll = Map<String, List<EmrDocumentModel>>();
            mapStartPageAll = Map<String, int>();
            setState(() {});
          }
        } else {
          daysValue = newValue!;
          filterModel.totalDays = newValue!;
          setState(() {});
        }
      },
    );
  }

  Future<void> searchDocumentChange(String query) async {
    log('query : $query');
    if (query != '') {}
    currentPageNum = 0;
    mapDataAll = Map<String, List<EmrDocumentModel>>();
    mapStartPageAll = Map<String, int>();
    // filterModel = FilterModel()
    //   ..totalDays = daysValue
    //   ..documentTypeId = null
    //   ..documentTypeName = '';
    setState(() {});
  }

  Future<List<EmrDocumentModel>?> getDocument(
      {bool ismaxScrollExtent = false}) async {
    if (ismaxScrollExtentState) {
      ismaxScrollExtentState = false;

      return mapDataAll[widget.option]!.isNotEmpty
          ? mapDataAll[widget.option]
          : null;
    }

    //return documentListMemoizer.runOnce(() async {
    isloading = true;
    List<EmrDocumentModel> result = <EmrDocumentModel>[];
    DateTime toDate = DateTime.now();
    DateTime fromDate = DateTime(toDate.year, toDate.month - 1, 1, 0, 0, 0);
    if (filterModel.totalDays == DateConstans.motThang) {
      fromDate = Jiffy().subtract(days: 30).dateTime;
    } else if (filterModel.totalDays == DateConstans.haiTuan) {
      fromDate = Jiffy().subtract(days: 14).dateTime;
    } else if (filterModel.totalDays == DateConstans.motTuan) {
      fromDate = Jiffy().subtract(days: 7).dateTime;
    } else if (filterModel.totalDays == DateConstans.homQua) {
      fromDate = Jiffy().subtract(days: 1).dateTime;
    } else if (filterModel.totalDays == DateConstans.tuyChon) {
      fromDate = filterModel.fromDate ?? DateTime.now();
      toDate = filterModel.toDate ?? DateTime.now();
    }

    final DateFormat formatterFromDate = DateFormat('yyyyMMdd000000');
    final DateFormat formatterToDate = DateFormat('yyyyMMdd235959');

    Map<String, dynamic> apiData = <String, dynamic>{
      'NEXT_SIGNER__EXACT': LoginStore.acsTokenModel!.User!.LoginName!,
      'ORDER_FIELD': 'CREATE_TIME',
      'ORDER_DIRECTION': 'DESC',
      'IS_REJECTER_NOT_NULL': false,
      'IS_DELETE': false,
      'KEY_WORD_UNSIGN': controllerDocumentFilter.text,
      'CREATE_DATE_FROM': formatterFromDate.format(fromDate).toString(),
      'CREATE_DATE_TO': formatterToDate.format(toDate).toString(),
    };

    if (widget.option == 'signed') {
      apiData = <String, dynamic>{
        'SIGNERS': LoginStore.acsTokenModel!.User!.LoginName!,
        'ORDER_FIELD': "CREATE_TIME",
        'ORDER_DIRECTION': "DESC",
        'IS_DELETE': false,
        'KEY_WORD_UNSIGN': controllerDocumentFilter.text,
        'CREATE_DATE_FROM': formatterFromDate.format(fromDate).toString(),
        'CREATE_DATE_TO': formatterToDate.format(toDate).toString(),
      };
    } else if (widget.option == 'creator') {
      apiData = <String, dynamic>{
        'CREATOR': LoginStore.acsTokenModel!.User!.LoginName!,
        'ORDER_FIELD': "CREATE_TIME",
        'ORDER_DIRECTION': "DESC",
        'IS_DELETE': false,
        'KEY_WORD_UNSIGN': controllerDocumentFilter.text,
        'CREATE_DATE_FROM': formatterFromDate.format(fromDate).toString(),
        'CREATE_DATE_TO': formatterToDate.format(toDate).toString(),
      };
    } else if (widget.option == 'rejected') {
      apiData = <String, dynamic>{
        'REJECTER__EXACT': LoginStore.acsTokenModel!.User!.LoginName!,
        'ORDER_FIELD': "CREATE_TIME",
        'ORDER_DIRECTION': "DESC",
        'IS_DELETE': false,
        'KEY_WORD_UNSIGN': controllerDocumentFilter.text,
        'CREATE_DATE_FROM': formatterFromDate.format(fromDate).toString(),
        'CREATE_DATE_TO': formatterToDate.format(toDate).toString(),
      };
    } else if (widget.option == 'canceled') {
      apiData = <String, dynamic>{
        'CANCEL_LOGINNAME__EXACT': LoginStore.acsTokenModel!.User!.LoginName!,
        'ORDER_FIELD': "CREATE_TIME",
        'ORDER_DIRECTION': "DESC",
        'IS_DELETE': true,
        'KEY_WORD_UNSIGN': controllerDocumentFilter.text,
        'CREATE_DATE_FROM': formatterFromDate.format(fromDate).toString(),
        'CREATE_DATE_TO': formatterToDate.format(toDate).toString(),
      };
    }
    if (filterModel.documentTypeId != null) {
      apiData['DOCUMENT_TYPE_ID'] = filterModel.documentTypeId;
    }
    if (mapDataAll == {}) {
      mapDataAll = Map<String, List<EmrDocumentModel>>();
    }
    if (mapDataAll[widget.option] == null || !ismaxScrollExtent)
      mapDataAll[widget.option] = <EmrDocumentModel>[];
    ;

    if (mapStartPageAll == {}) {
      mapStartPageAll = Map<String, int>();
    }
    if (mapStartPageAll[widget.option] == null || !ismaxScrollExtent)
      mapStartPageAll[widget.option] = 0;
    ;

    final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.getPaging(
        '${BackendDomain.emr}${EmrUri.api_EmrDocument_GetView}',
        apiData: apiData,
        commonParam: <String, dynamic>{
          'Limit': limitPage,
          'Start': mapStartPageAll[widget.option],
        });
    print('||||||||||||||||||||||${apiResultModel.Data}');
    if (apiResultModel.Data != null) {
      result = (apiResultModel.Data as List)
          .map((e) => EmrDocumentModel.fromJson(e as Map<String, dynamic>))
          .toList();
      mapDataAll[widget.option]!.addAll(result);
      mapDataAll[widget.option]!.sort(
          (EmrDocumentModel a, EmrDocumentModel b) =>
              b.CREATE_TIME!.compareTo(a.CREATE_TIME!));
      //startPage += limitPage;
      mapStartPageAll[widget.option] =
          mapStartPageAll[widget.option]! + limitPage;
    }
    // isloading = false;
    // countNum = (apiResultModel.Param != null
    //     ? int.parse(apiResultModel.Param['Count'].toString())
    //     : 0);
    //
    // pageNumMax = (countNum / limitPage).toInt();
    // final int du = (countNum % limitPage);
    // if (du > 0) pageNumMax += 1;
    // if (pageNumMax == 0) pageNumMax = 1;

    // setState(() {
    //   //isloading = load;
    // });
    if (ismaxScrollExtent) {
      ismaxScrollExtentState = true;
      setState(() {});
    }

    return mapDataAll[widget.option]!.isNotEmpty
        ? mapDataAll[widget.option]
        : null;
    //});
    print('<<<<<<<<<<<<<object>>>>>>>>>>>>>${mapDataAll[widget.option]}');
  }
}
