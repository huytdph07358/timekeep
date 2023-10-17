import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vss_theme/theme_store.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_ivt_api/dot_net_api.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:emr_backend_domain/backend_domain.dart';
// import 'package:job_search/components/JSJobDetailComponent.dart';
// import 'package:job_search/components/JSRemoveJobComponent.dart';
// import 'package:job_search/model/JSPopularCompanyModel.dart';
// import 'package:job_search/screens/JSHomeScreen.dart';
// import 'package:job_search/utils/JSColors.dart';
// import 'package:job_search/utils/JSDataGenerator.dart';
// import 'package:job_search/main.dart';

import '../l10n/translate.dart';
import '../model/emr_document_model.dart';

typedef DocumentProcessCallback = Future<void> Function(bool success);

class FilteredResultComponent extends StatefulWidget {
  const FilteredResultComponent(
      {super.key,
      required this.filteredResultsList,
      this.index,
      required this.option,
      this.onDocumentProcessCallback});
  final EmrDocumentModel filteredResultsList;
  final String option;
  final int? index;
  final DocumentProcessCallback? onDocumentProcessCallback;

  @override
  State<FilteredResultComponent> createState() =>
      _FilteredResultComponentState();
}

class _FilteredResultComponentState extends State<FilteredResultComponent> {
  //List<EmrDocumentModel> removeJobsList = getRemoveJobsList();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat longDateFormat =
      DateFormat.yMd(LanguageStore.localeSelected.languageCode).add_jm();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final TextEditingController reasonController = TextEditingController();

    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              spreadRadius: 0.6, blurRadius: 1, color: gray.withOpacity(0.5)),
        ],
        backgroundColor: context.scaffoldBackgroundColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: boxDecorationRoundedWithShadow(
              8,
              backgroundColor: ThemeStore.isDarkModeOn
                  ? scaffoldDarkColor
                  : colorScheme.background,
            ),
            padding: const EdgeInsets.all(8),
            //width: 165,
            child: Row(
              children: [
                const Icon(Icons.date_range_rounded, size: 18),
                4.width,
                Text(
                  longDateFormat.format(
                      widget.filteredResultsList.getDateTimeCreateTime()!),
                  style: boldTextStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).flexible(),
              ],
            ),
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.document_scanner_outlined, size: 18),
                  4.width,
                  Text(widget.filteredResultsList.DOCUMENT_TYPE_NAME ?? 'Khác',
                      style: boldTextStyle()),
                ],
              ),
              8.width,
              if (widget.option != 'canceled')
                const Icon(Icons.delete_outline, size: 35).onTap(() async {
                  // Add BottomSheet Code
                  bool? confirmDelete = await showModalBottomSheet(
                      enableDrag: true,
                      context: context,
                      barrierColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.4),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      builder: (BuildContext dialogContext) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(dialogContext, false);
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(
                                      GlobalConstant.paddingMarginLength),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              controller: reasonController,
                                              keyboardType: TextInputType.text,
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                labelText: translate.lyDo,
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      reasonController.clear(),
                                                  icon: const Icon(
                                                      Icons.clear_outlined),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return translate
                                                      .duLieuBatBuoc;
                                                }
                                                // if (value.length < 20) {
                                                //   return translate.doDaiToiThieu20KyTu;
                                                // }
                                                return null;
                                              },
                                            )
                                          ]))),
                              Expanded(child: Container()),
                              Padding(
                                padding: const EdgeInsets.all(
                                    GlobalConstant.paddingMarginLength),
                                child: Column(
                                  children: <Widget>[
                                    GlobalConstant.rowDivider,
                                    SizedBox(
                                      width: double.infinity,
                                      child: FilledButton(
                                        onPressed: () {
                                          //TODO
                                          Navigator.pop(dialogContext, true);
                                        },
                                        child: Text(translate.dongY),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: FilledButton(
                                        onPressed: () {
                                          //TODO
                                          Navigator.pop(dialogContext, false);
                                        },
                                        child: Text(translate.boQua),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });

                  if (confirmDelete != null && confirmDelete == true) {
                    final ApiResultModel apiResultModel =
                        await ApiConsumer.dotNetApi.post(
                            '${BackendDomain.emr}${EmrUri.api_EmrDocument_Cancel}',
                            body: <String, Map<String, dynamic?>>{
                          'ApiData': <String, dynamic?>{
                            'DocumentId': widget.filteredResultsList.ID,
                            'CancelReason': reasonController.text,
                          }
                        });

                    if (apiResultModel.Data != null) {
                      await widget.onDocumentProcessCallback?.call(true);
                    }
                  }
                })
              else
                const SizedBox.shrink(),
            ],
          ),
          4.height,
          Row(
            children: [
              Icon(
                Icons.person_2_outlined,
                size: 18,
              ),
              4.width,
              Flexible(
                child: new Text(
                    'Bệnh nhân: ${widget.filteredResultsList.VIR_PATIENT_NAME} ${widget.filteredResultsList.DEPARTMENT_NAME != null ? "  - " + widget.filteredResultsList.DEPARTMENT_NAME! : ""}',
                    style: primaryTextStyle()),
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(8),
              //width: 165,
              child: Row(
                children: [
                  16.width,
                  Text(
                      'Mã bệnh nhân: ${widget.filteredResultsList.PATIENT_CODE}',
                      style: secondaryTextStyle()),
                ],
              )),
          4.height,
          InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamed(
                    context, '/emr_document_file/DocumentFileScreen',
                    arguments: <String, dynamic>{
                      'DocumentData': widget.filteredResultsList.toJson()
                    });
              },
              child: Row(children: [
                Icon(Icons.attach_file_outlined,
                    size: 18, color: gray.withOpacity(0.8)),
                4.width,
                Flexible(
                    child: new Text(
                        widget.filteredResultsList.DOCUMENT_NAME ?? '',
                        style: secondaryTextStyle()))
              ])),
        ],
      ),
    ).onTap(() {
      Navigator.pushNamed(context, '/emr_document_detail/DocumentDetailScreen',
          arguments: <String, dynamic>{
            'DocumentData': widget.filteredResultsList.toJson()
          });
    });
  }
}
