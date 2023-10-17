

import 'dart:math';

import 'package:emr_app_bar/emr_app_bar.dart';
import 'package:emr_app_store/login_store.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_login/configuration_screen.dart';
import 'package:emr_sign_processor/emr_sign_processor.dart';
import 'package:emr_sign_processor/model/document_sign_model.dart';
import 'package:emr_sign_processor/model/point_sign_model.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vss_date_time_util/date_time_util.dart';
import 'package:vss_global_constant/global_constant.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_locale/language_store.dart';
import 'package:vss_message_util/message_util.dart';

import 'l10n/translate.dart';
import 'model/emr_document_model.dart';
import 'model/emr_document_watermark_model.dart';
import 'model/emr_sign_model.dart';

class DocumentDetailScreen extends StatefulWidget {
  DocumentDetailScreen({super.key, this.documentModel});
  EmrDocumentModel? documentModel;

  @override
  State<DocumentDetailScreen> createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends State<DocumentDetailScreen> {
  final String screenLink = '/emr_document_detail/DocumentDetailScreen';
  String? qrcode;
  String? serviceCode;
  EmrSignModel? emrSignModel;
  PointSignModel? pointSignModel;
  DocumentSignModel? documentSignModel;
  late bool formSubmittingQrTurn = false;
  final ValueNotifier<bool> submitNotifierQrTurn = ValueNotifier<bool>(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat dateFormat =
      DateFormat.yMd(LanguageStore.localeSelected.languageCode);

  final ValueNotifier<bool> submitNotifier = ValueNotifier<bool>(false);
  final DateFormat longDateFormat =
      DateFormat.yMd(LanguageStore.localeSelected.languageCode).add_jm();
   late bool formSubmitting = false;
  final TextEditingController _currentsController =
      TextEditingController();
  int i = 0;
  EmrDocumentWaterMarkModel? emrDocumentWaterMarkModel;
  EmrDocumentWaterMarkModel? emrDocumentWater;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Map<String, dynamic> argument =
          ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
      widget.documentModel = argument.containsKey('DocumentData')
          ? EmrDocumentModel.fromJson(argument['DocumentData']!)
          : widget.documentModel;
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Translate translate = lookupTranslate(LanguageStore.localeSelected);
    return Scaffold(
        appBar: EmrAppBar(
          title: translate.chiTietVanBan,
          screenLink: screenLink,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(GlobalConstant.paddingMarginLength),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.documentModel?.DOCUMENT_TYPE_NAME ?? '',
                        ),
                      ),
                    ],
                  ),
                  GlobalConstant.colDivider,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child : Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: const Text('Thông tin bệnh nhân'),
                        ),
                        GlobalConstant.colDivider,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Text('Ngày trình:'),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      longDateFormat.format(DateTimeUtil.parse(
                                          widget.documentModel!.CREATE_TIME)!),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              GlobalConstant.colDivider,
                              Row(
                                children: <Widget>[
                                  const Text('Người trình:'),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      '${widget.documentModel?.REQUEST_LOGINNAME ?? ''} - ${widget.documentModel?.REQUEST_USERNAME ?? ''}',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              GlobalConstant.colDivider,
                              Row(
                                children: <Widget>[
                                  const Text('Bệnh nhân:'),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      widget.documentModel?.VIR_PATIENT_NAME ?? '',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              GlobalConstant.colDivider,
                              Row(
                                children: <Widget>[
                                  const Text('Mã điều trị: '),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      widget.documentModel?.TREATMENT_CODE ?? '',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              GlobalConstant.colDivider,
                              Row(
                                children: <Widget>[
                                  const Text('Mã bệnh nhân: '),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      widget.documentModel?.PATIENT_CODE ?? '',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              GlobalConstant.colDivider,
                              Row(
                                children: <Widget>[
                                  const Text('Ngày sinh: '),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      widget.documentModel?.DOB != null
                                          ? dateFormat.format(DateTimeUtil.parse(
                                              widget.documentModel!.DOB)!)
                                          : '',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              GlobalConstant.colDivider,
                              Row(
                                children: <Widget>[
                                  const Text('Giới tính: '),
                                  GlobalConstant.rowDivider,
                                  Expanded(
                                    child: Text(
                                      widget.documentModel?.GENDER_NAME ?? '',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )

                      ],
                    )
                  ),
                  GlobalConstant.colDivider,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context, '/emr_document_file/DocumentFileScreen',
                        arguments: <String, dynamic>{
                          'DocumentData': widget.documentModel!.toJson()
                        });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Văn bản ký'),
                            const SizedBox(height: 6,),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.file_present_outlined),
                                  Container(
                                    width: 200,
                                    child: Text(widget.documentModel?.DOCUMENT_NAME ?? '',overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
                  GlobalConstant.colDivider,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7),
                            ),
                          ),
                          child: const Text('Danh sách người ký')),
                        const SizedBox(height: 8,),
                        FutureBuilder<List<EmrSignModel>?>(
                          future: getList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<EmrSignModel>?> snapshot) {
                            Widget child;
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              child = const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              child = Text(
                                snapshot.error.toString(),
                              );
                            }
                            if (snapshot.hasData) {
                              child = ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (BuildContext context, int index) {
                                  return const Divider();
                                },
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  print('aaaaaaaaaaaaaaa${snapshot.data![index].IS_SIGNING }');
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('${snapshot.data![index].USERNAME}'),
                                        (snapshot.data![index].SIGN_TIME != null  && snapshot.data![index].IS_SIGNING == null) ? const Text('Đã ký') : (snapshot.data![index].SIGN_TIME == null && snapshot.data![index].IS_SIGNING == 1) ? const Text('Đang ký') 
                                        : (snapshot.data![index].REJECT_TIME != null )? const Text('Từ chối') : const Text('Chờ ký')
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              child = const Center(
                                child: Text('data'),
                              );
                            }
                            return child;
                          },
                        ),
                        const SizedBox(height: 8,)
                      ],
                    ),
                  ),
                  GlobalConstant.colDivider,
                  GlobalConstant.colDivider,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: widget.documentModel!.IS_MULTI_SIGN == 1 ? Colors.grey : Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
                                widget.documentModel!.IS_MULTI_SIGN == 1 ?  null : ketThuc();
                              },
                              child: !formSubmittingQrTurn
                                  ? const Text('Kết thúc')
                                  : CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                    ),
                            ),
                          ),
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
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
                                kys('');
                              },
                              child: !formSubmittingQrTurn
                                  ? const Text('Ký')
                                  : CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                    ),
                            ),
                          ),
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
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {                             
                                print('>>>>>>>>>>>>>');
                                _dialogBuilder(context);
                              },
                              child: !formSubmittingQrTurn
                                  ? const Text('Ký & ghi chú')
                                  : CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ký & ghi chú'),
          content: TextFormField(
            controller: _currentsController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Lý do',
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Gửi'),
              onPressed: () {
                if(_currentsController.text == ''){
                  return;
                } else{
                  kys(_currentsController.text);
                  Navigator.pop(context);
                 _currentsController.text = '';
                }
                 
                 
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> kys(String description) async {
     final Map<String, dynamic> body = <String, dynamic>{
        'DOCUMENT_ID': widget.documentModel!.ID,
        'IS_INCLUDE_POINT': true,

      };
      // List<EmrDocumentWaterMarkModel> result1 = <EmrDocumentWaterMarkModel>[];
      final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.get(
          '${BackendDomain.emr}${EmrUri.api_EmrDocument_GetWatermark}', param: body, );
      print('<<<<<<<<<<object55555555555>>>>>>>>>>${apiResultModel.Data['PointSigns']}');
      // result1 = (apiResultModel.Data as List)
      //         .map((element) =>
      //             EmrDocumentWaterMarkModel.fromJson(element))
      //         .toList();

      
      emrDocumentWaterMarkModel = EmrDocumentWaterMarkModel.fromJson(apiResultModel.Data);
      final Map<String, dynamic> body1 = <String, dynamic>{
              'DOCUMENT_ID': widget.documentModel!.ID.toString() ?? '',
              'ORDER_FIELD':'NUM_ORDER',
              'ORDER_DIRECTION':'ASC'
        };
        List<EmrSignModel> result = <EmrSignModel>[];
        final ApiResultModel apiResultModel1 = await ApiConsumer.dotNetApi.get(
            '${BackendDomain.emr}${EmrUri.api_EmrSign_Get}', param: body1, );
        result = (apiResultModel1.Data as List)
              .map((element) =>
                  EmrSignModel.fromJson(element))
              .toList();
              // .where((element) => element.LOGINNAME == LoginStore.acsTokenModel?.User?.LoginName)
              // .toList();


        emrSignModel = result.first;
        print(';;;;;;;;;;;;;;;;;;;;;;;;;;${emrSignModel!.NUM_ORDER}');


        // var index = result.where((EmrSignModel element) => element.NUM_ORDER == emrDocumentWater!.TextString);
        List<PointSignModel>? pointSignModel = <PointSignModel>[];
        if(emrDocumentWaterMarkModel!=null && emrDocumentWaterMarkModel!.PointSigns!=null && emrDocumentWaterMarkModel!.PointSigns!.length>0){
          // for(i=0;i < index.length; i++){
          emrDocumentWaterMarkModel!.PointSigns!.forEach((element) {
            pointSignModel.add(PointSignModel()
            ..CoorXRectangle = element.CoorXRectangle
            ..CoorYRectangle = element.CoorYRectangle
            ..MaxPageNumber = element.MaxPageNumber
            ..PageNumber = element.PageNumber
            );
          });  
        }else {
          Navigator.pushNamed(
          context, '/emr_document_file/DocumentFileScreen',
          arguments: <String, dynamic>{
            'DocumentData': widget.documentModel!.toJson(),
            'EmrDocumentWaterMarkModel': emrDocumentWaterMarkModel,
            'EmrSignModel': emrSignModel
          });
        }
      documentSignModel = DocumentSignModel()
      ..DocumentId = widget.documentModel!.ID
      ..Description = ''
      ..DocumentHeight = emrDocumentWaterMarkModel!.DocumentHeight
      ..DocumentWidth = emrDocumentWaterMarkModel!.DocumentWidth
      ..Base64Data = emrDocumentWaterMarkModel!.Base64Data
      ..IS_MULTI_SIGN = widget.documentModel!.IS_MULTI_SIGN
      ..DocumentTypeId = widget.documentModel!.DOCUMENT_TYPE_ID
      ..PointSigns = pointSignModel;
      // setState(() {
        print('>>>>>>>>>>>>>>${pointSignModel.toList()}');
        EmrSignProcessor.sign(documentSignModel! , context);
      // });
  }


  Future<List<EmrSignModel>?> getList() async {

    final Map<String, dynamic> body = <String, dynamic>{
          'DOCUMENT_ID': widget.documentModel!.ID.toString() ?? '',
          //LOGINNAME__EXACT: loginName,
          'ORDER_FIELD':'NUM_ORDER',
          'ORDER_DIRECTION':'ASC'
    };
   
    List<EmrSignModel> result = <EmrSignModel>[];
    final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.get(
        '${BackendDomain.emr}${EmrUri.api_EmrSign_GetView}', param: body, );
    print('/////////////////////${apiResultModel.Data}');
    if (apiResultModel.Data != null) {
      result = (apiResultModel.Data as List)
          .map((element) =>
              EmrSignModel.fromJson(element))
          .toList();
    }
    print('<<<<<<<<<<object>>>>>>>>>>${result}');
    return result.isNotEmpty ? result : null;
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

  // Future<void> ky() async {
  //   Navigator.of(context).EmrSignProcessor();
  // }
}
