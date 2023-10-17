import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/emr_uri.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:vss_message_util/message_util.dart';

import 'model/document_sign_model.dart';

class EmrSignProcessor {
 static Future<bool> sign(
      DocumentSignModel documentSignModel, BuildContext context) async {
    //TODO hàm xử lý ký hoặc ký có kèm ghi chú
    //bên ngoài gọi hàm truyền vào đủ các giá trị vào model đầu vào
    //đầu ra trả về true/false
   print('<>>>>>>>>>>>>>>>>>>>>>>${documentSignModel.PointSigns}');
    bool success = false;
    try {
      if (documentSignModel.PointSigns != null &&
          documentSignModel.PointSigns!.isNotEmpty) {
        final DateFormat formatterDate = DateFormat('yyyyMMddHHmmss');
        int dem = 0;
        for (var pointSignItem in documentSignModel.PointSigns!) {
          bool isFinishSign = (documentSignModel.PointSigns!.length == 1
              ? documentSignModel.IS_MULTI_SIGN == 1
                  ? false
                  : true
              : dem == documentSignModel.PointSigns!.length - 1
                  ? true
                  : false);
          Map<String, Map<String, dynamic>> bodyApiData =
              <String, Map<String, dynamic>>{
            'ApiData': <String, dynamic>{
              'EmrDocumentId': documentSignModel.DocumentId,
              'EmrSignId': pointSignItem.SignId,
              'SignTime': formatterDate.format(DateTime.now()),
              'Description': documentSignModel.Description,
              'IsFinishSign': isFinishSign,
              'IsSigning': !isFinishSign,
              'PointSign': {
                'CoorXRectangle': pointSignItem.CoorXRectangle,
                'CoorYRectangle': pointSignItem.CoorYRectangle,
                'PageNumber': pointSignItem.PageNumber,
                'MaxPageNumber': pointSignItem.MaxPageNumber,
                'FormatRectangleText': null,
              },
            }
          };
          ApiResultModel apiResultModel = await ApiConsumer.dotNetApi.post(
              '${BackendDomain.acs}${EmrUri.api_EmrSign_SignPdfHsm}',
              body: bodyApiData);
          print('<<<<<<<<<<<<<object>>>>>>>>>>>>>${apiResultModel.Data}');
          if (apiResultModel.Success && apiResultModel.Data != null) {
            success = true;
            // DocumentDependencyProcessor.SignDependencies();
            if (documentSignModel.PointSigns!.length == 1 ||
                dem == documentSignModel.PointSigns!.length - 1) {
              MessageUtil.snackbar(context,
                  message: 'Xử lý thành công', success: true);
            }
          } else {
            print('????????????>>>>>>>>>>');
            MessageUtil.snackbar(context,
                message: apiResultModel.getMessage(), success: false);
          }
        }
      }
    } catch (e) {
      // log(e);
    }
    return success;
  }
}
