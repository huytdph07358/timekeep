import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vss_locale/language_store.dart';
import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:vss_theme/theme_store.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'date_constans.dart';
import 'l10n/translate.dart';
import 'model/emr_document_type_model.dart';
import 'model/filter_model.dart';
import 'package:vss_global_constant/global_constant.dart';

class FilteredScreen extends StatefulWidget {
  FilteredScreen({super.key, required this.filterModel});

  FilterModel filterModel;
  @override
  _FilteredScreenState createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  final String screenLink = '/emr_document/FilteredScreen';
  String? daysValue = DateConstans.motThang;
  EmrDocumentTypeModel? documentTypeDropdownValue;
  List<EmrDocumentTypeModel> documentTypeList = <EmrDocumentTypeModel>[];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool formSubmitting = false;
  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    daysValue = widget.filterModel.totalDays;
    getListDocumentType();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    submitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: EmrAppBar(
          title: translate.dieuKienLoc,
          screenLink: screenLink,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(
            GlobalConstant.paddingMarginLength,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                chooseDateDropdownButton(
                    labelText: translate.thoiGian, width: context.width()),
                Visibility(
                  visible: daysValue == DateConstans.tuyChon,
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: widget.filterModel.fromDate != null &&
                            widget.filterModel.toDate != null
                        ? PickerDateRange(widget.filterModel.fromDate,
                            widget.filterModel.toDate)
                        : null,
                  ),
                ),
                if (daysValue == DateConstans.tuyChon)
                  Divider(color: gray.withOpacity(0.4))
                else
                  const SizedBox.shrink(),
                GlobalConstant.colDivider,
                chooseDocumentTypeDropdownButton(
                    labelText: translate.loaiVanBan, width: context.width()),
                GlobalConstant.colDivider,
                Text(translate.sapXepTheo),
                GlobalConstant.colDivider,
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<bool>(
                      valueListenable: submitNotifier,
                      builder: (BuildContext context, bool val, Widget? child) {
                        return FilledButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (formSubmitting) {
                                return;
                              }
                              formSubmitting = true;
                              submitNotifier.value = true;

                              widget.filterModel.totalDays = daysValue;
                              if (documentTypeDropdownValue != null) {
                                widget.filterModel.documentTypeId =
                                    documentTypeDropdownValue!.ID;
                                widget.filterModel.documentTypeName =
                                    documentTypeDropdownValue!
                                        .DOCUMENT_TYPE_NAME;
                              } else {
                                widget.filterModel.documentTypeId = null;
                                widget.filterModel.documentTypeName = null;
                              }
                              Navigator.pop(context, widget.filterModel);
                              formSubmitting = false;
                              submitNotifier.value = false;
                            }
                          },
                          child: !formSubmitting
                              ? Text(translate.dongY)
                              : CircularProgressIndicator(
                                  color: colorScheme.onPrimary),
                        );
                      }),
                ),
              ],
            ),
          ),
        )));
  }

  Widget chooseDateDropdownButton({
    String? labelText,
    double? width,
  }) {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        menuMaxHeight: MediaQuery.of(context).size.height * 0.55,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: gray.withOpacity(0.4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: gray.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          labelText: labelText,
        ),
        value: daysValue,
        onChanged: (String? value) {
          if (value != DateConstans.tuyChon) {
            widget.filterModel.fromDate = null;
            widget.filterModel.toDate = null;
          }
          setState(() {
            daysValue = value!;
          });
        },
        items: DateConstans.daysItems
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value!,
              textAlign: TextAlign.left,
            ),
          );
        }).toList(),
        validator: (String? value) {
          // if (value == null) {
          //   return translate.duLieuBatBuoc;
          // }
          return null;
        },
      ),
    );
  }

  Widget chooseDocumentTypeDropdownButton({
    String? labelText,
    double? width,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<EmrDocumentTypeModel>(
        isExpanded: true,
        menuMaxHeight: MediaQuery.of(context).size.height * 0.55,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: gray.withOpacity(0.4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: gray.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          labelText: labelText,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                documentTypeDropdownValue = null;
              });
            },
            icon: const Icon(Icons.clear_outlined, size: 15),
          ),
        ),
        value: documentTypeDropdownValue,
        onChanged: (EmrDocumentTypeModel? value) {
          setState(() {
            documentTypeDropdownValue = value;
          });
        },
        items: documentTypeList.map<DropdownMenuItem<EmrDocumentTypeModel>>(
            (EmrDocumentTypeModel value) {
          return DropdownMenuItem<EmrDocumentTypeModel>(
            value: value,
            child: Text(
              value.DOCUMENT_TYPE_NAME!,
              textAlign: TextAlign.left,
            ),
          );
        }).toList(),
        validator: (EmrDocumentTypeModel? value) {
          // if (value == null) {
          //   return translate.duLieuBatBuoc;
          // }
          return null;
        },
      ),
    );
  }

  Future<void> getListDocumentType() async {
    final param = {'IS_ACTIVE': 1};
    final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.get(
        '${BackendDomain.emr}${EmrUri.api_EmrDocumentType_Get}',
        param: param);
    if (apiResultModel.Data != null) {
      {
        documentTypeList = (apiResultModel.Data as List)
            .map(
                (e) => EmrDocumentTypeModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      if (widget.filterModel.documentTypeId != null) {
        documentTypeDropdownValue = documentTypeList
            .where(
                (element) => element.ID == widget.filterModel.documentTypeId!)
            .first;
      }

      setState(() {});
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        // _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // // ignore: lines_longer_than_80_chars
        //     ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        if (args.value.startDate != null)
          widget.filterModel.fromDate = args.value.startDate as DateTime;
        if (args.value.endDate != null)
          widget.filterModel.toDate = args.value.endDate as DateTime;
      } else if (args.value is DateTime) {
        //_selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        //_dateCount = args.value.length.toString();
      } else {
        //_rangeCount = args.value.length.toString();
      }
    });
  }
}
