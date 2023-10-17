import 'package:json_annotation/json_annotation.dart';
import 'package:vss_date_time_util/date_time_util.dart';
part 'emr_document_type_model.g.dart';

@JsonSerializable()
class EmrDocumentTypeModel {
  EmrDocumentTypeModel();

  factory EmrDocumentTypeModel.fromJson(Map<String, dynamic> json) =>
      _$EmrDocumentTypeModelFromJson(json);
  int? ID;
  String? DOCUMENT_TYPE_CODE;
  String? DOCUMENT_TYPE_NAME;
  int? CREATE_TIME;
  int? MODIFY_TIME;
  int? IS_ACTIVE;
  int? NUM_ORDER;
  int? IS_MULTI_SIGN;
  DateTime? getDateTimeCreateTime() {
    return DateTimeUtil.parse(CREATE_TIME);
  }

  DateTime? getDateTimeModifyTime() {
    return DateTimeUtil.parse(MODIFY_TIME);
  }

  Map<String, dynamic> toJson() => _$EmrDocumentTypeModelToJson(this);
}
