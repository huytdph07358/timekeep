import 'package:json_annotation/json_annotation.dart';
import 'package:vss_date_time_util/date_time_util.dart';
part 'emr_document_model.g.dart';

@JsonSerializable()
class EmrDocumentModel {
  EmrDocumentModel();

  factory EmrDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$EmrDocumentModelFromJson(json);
  int? ID;
  String? DOCUMENT_TYPE_CODE;
  int? CREATE_TIME;
  int? MODIFY_TIME;
  String? DOCUMENT_TYPE_NAME;
  int? DOCUMENT_TYPE_ID;
  String? DOCUMENT_CODE;
  String? DOCUMENT_NAME;
  String? DEPARTMENT_NAME;
  String? VIR_PATIENT_NAME;
  String? PATIENT_CODE;
  String? TREATMENT_CODE;
  int? IS_ACTIVE;
  int? IS_MULTI_SIGN;
  int? DOB;
  String? GENDER_NAME;
  String? REQUEST_LOGINNAME;
  String? REQUEST_USERNAME;
  String? Base64Data;
  double? DocumentWidth;
  double? DocumentHeight;
  DateTime? getDateTimeCreateTime() {
    return DateTimeUtil.parse(CREATE_TIME);
  }

  DateTime? getDateTimeModifyTime() {
    return DateTimeUtil.parse(MODIFY_TIME);
  }

  Map<String, dynamic> toJson() => _$EmrDocumentModelToJson(this);
}
