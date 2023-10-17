import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vss_message_util/message_util.dart';
import 'custom_tap_gesture_recognizer.dart';
import 'l10n/translate.dart';
import 'model/emr_document_file_model.dart';
import 'model/emr_document_model.dart';
import 'model/emr_document_watermark_model.dart';
import 'model/emr_sign_model.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DocumentFileScreen extends StatefulWidget {
  DocumentFileScreen({super.key, this.documentModel});
  EmrDocumentModel? documentModel;

  @override
  State<DocumentFileScreen> createState() => _DocumentFileScreenState();
}

class _DocumentFileScreenState extends State<DocumentFileScreen> {
  final String screenLink = '/emr_document_file/DocumentFileScreen';
  late bool formSubmitting = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EmrSignModel? emrSignModel;
  final DateFormat dateFormat =
      DateFormat.yMd(LanguageStore.localeSelected.languageCode);
  final NumberFormat currencyFormat = NumberFormat.currency(
      locale: LanguageStore.localeSelected.languageCode,
      symbol: 'đ',
      decimalDigits: 0);
  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);
  EmrDocumentFileModel documentFileModel = EmrDocumentFileModel();
  AsyncMemoizer<EmrDocumentFileModel?> documentFileMemoizer =
      AsyncMemoizer<EmrDocumentFileModel?>();
  String base64Data = '';
  bool isloading = false;
  bool isMultiSign = false;
  EmrDocumentWaterMarkModel? emrDocumentWaterMarkModel;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  int currentPageNumber = 0;
  int maxPageNumber = 0;
  PdfViewerController pdfViewerController = PdfViewerController();

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;

  Future<EmrDocumentFileModel?> getDocuemntWatermark(
      {bool ismaxScrollExtent = false}) async {
    return documentFileMemoizer.runOnce(() async {
      isloading = true;
      Map<String, dynamic> apiParam = <String, dynamic>{
        'EmrDocumentWaterMarkModel' : emrDocumentWaterMarkModel,
        'EmrSignModel' : emrSignModel,
        'DOCUMENT_ID':
            widget.documentModel != null ? widget.documentModel!.ID : 0,
        'IS_INCLUDE_POINT': true,
      };

      final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.get(
          '${BackendDomain.emr}${EmrUri.api_EmrDocument_GetWatermark}',
          param: apiParam);

      if (apiResultModel.Data != null) {
        documentFileModel = EmrDocumentFileModel.fromJson(
            apiResultModel.Data as Map<String, dynamic>);
        base64Data = documentFileModel.Base64Data ?? '';

        isMultiSign = widget.documentModel?.IS_MULTI_SIGN == 1;
      }
      isloading = false;
      setState(() {});
      return documentFileModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Map<String, dynamic?> argument =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic?>;
      widget.documentModel = argument.containsKey('DocumentData')
          ? EmrDocumentModel.fromJson(argument['DocumentData']!)
          : widget.documentModel;
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);

    getDocuemntWatermark();

    return Scaffold(
      appBar: EmrAppBar(
        title: translate.fileVanBan,
        screenLink: screenLink,
      ),
      body: Form(
        key: formKey,
        child: !isloading
            ? Column(
                children: <Widget>[
                  GlobalConstant.colDivider,
                  buildPdfViewerExpanded(context, translate),
                  buildButton(context, translate, colorScheme)
                ],
              )
            : Column(
                children: [
                  GlobalConstant.colDivider,
                  Center(
                    child: CircularProgressIndicator(
                    color: colorScheme.onPrimary,
                  )),
                ],
              ),
      ),
    );
  }

  Expanded buildPdfViewerExpanded(BuildContext context, Translate translate) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GlobalConstant.colDivider,
            if (base64Data != '')
              SizedBox(
                  width: double.maxFinite,
                  height: (MediaQuery.of(context).size.height - 50),
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      log(details.localPosition.toString());
                      if ((details.localPosition.dx) > 0) {
                        // User swiped down
                        // currentPageNum = 0;
                        // pageNumMax = 0;
                        // mapDataAll = Map<String, List<EmrDocumentModel>>();
                        // mapStartPageAll = Map<String, int>();
                        // setState(() {});
                      }
                    },
                    child: PDFView(
                      pdfData: base64Decode(base64Data ?? ''),
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageFling: false,
                      gestureRecognizers: Set()
                        ..add(
                          Factory<CustomTapGestureRecognizer>(
                            () => CustomTapGestureRecognizer()
                              ..onTap = (Offset? initialPos) {
                                // make the buttons appear here
                                log(initialPos);
                              },
                          ),
                        ),
                      onRender: (_pages) {
                        setState(() {
                          pages = _pages;
                          //isReady = true;
                        });
                      },
                      onError: (error) {
                        log(error.toString());
                      },
                      onPageError: (page, error) {
                        log('$page: ${error.toString()}');
                      },
                      onViewCreated: (PDFViewController pdfViewController) {
                        _controller.complete(pdfViewController);
                      },
                      onPageChanged: (int? page, int? total) {
                        log('page change: $page/$total');
                      },
                    ),
                    // child: SfPdfViewer.memory(
                    //   base64Decode(base64Data ?? ''),
                    //   key: _pdfViewerKey,
                    //   controller: pdfViewerController,
                    //   onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    //     setState(() {
                    //       currentPageNumber = pdfViewerController.pageNumber;
                    //       maxPageNumber = pdfViewerController.pageCount;
                    //     });
                    //   },
                    //   onPageChanged: (PdfPageChangedDetails details) {
                    //     setState(() {
                    //       currentPageNumber = details.newPageNumber;
                    //     });
                    //   },
                    // ),
                  ))
            else
              Column(
                children: [
                  GlobalConstant.colDivider,
                  Center(
                    child: Text(
                      translate.khongTimThayFileVanBan,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Padding buildButton(
      BuildContext context, Translate translate, ColorScheme colorScheme) {
    final VoidCallback? onPressedFinish = isMultiSign
        ? () {
            //TODO
            //Code xử lý nút kết thúc
          }
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder(
              valueListenable: submitNotifier,
              builder: (BuildContext context, bool val, Widget? child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GlobalConstant.rowDivider,
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  onPressedFinish;
                                }
                              },
                              child: !formSubmitting
                              ? Text(translate.ketThuc)
                              : CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
                                ),
                            ),
                          )
                        ),
                      ),
                      GlobalConstant.rowDivider,
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  //TODO
                                  //Code xử lý nút ký
                                }
                              },
                              child: !formSubmitting
                              ? Text(translate.ky)
                              : CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
                                ),
                            ),
                          )
                        ),
                      ),
                      GlobalConstant.rowDivider,
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  //TODO
                                  //Code xử lý nút ký
                                }
                              },
                              child: !formSubmitting
                              ? Text(translate.kyVaGhiChu)
                              : CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
                                ),
                            ),
                          )
                        ),
                      ),
                    ]);
              },
            ),
          ),
          GlobalConstant.colDivider,
        ],
      ),
    );
  }

  Future<void> ketThuc() async {
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    if (formSubmitting) {
      return;
    }
    formSubmitting = true;
    submitNotifier.value = true;

    final Map<String, dynamic> body = <String, dynamic>{
          'DOCUMENT_ID': widget.documentModel!.ID.toString() ?? '',
          'ORDER_FIELD':'NUM_ORDER',
          'ORDER_DIRECTION':'ASC'
    };
    List<EmrSignModel> result = <EmrSignModel>[];
    final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.get(
        '${BackendDomain.emr}${EmrUri.api_EmrSign_Get}', param: body, );
    result = (apiResultModel.Data as List)
          .map((element) =>
              EmrSignModel.fromJson(element))
          .toList();

    emrSignModel = result.first;

    final Map<String, dynamic> body1 = <String, dynamic>{
      'ApiData': emrSignModel?.ID
    };

    

    
    final ApiResultModel EmrSignModels = await ApiConsumer.dotNetApi.post(
        '${BackendDomain.emr}${EmrUri.api_EmrSign_Finish}',
        body: body1);
    if (EmrSignModels.Data != null) {

      formSubmitting = false;
      submitNotifier.value = false;
    } else {
      MessageUtil.snackbar(context,
          message: EmrSignModels.getMessage() ?? '', success: false);
      formSubmitting = false;
      submitNotifier.value = false;
    }
  }
}
