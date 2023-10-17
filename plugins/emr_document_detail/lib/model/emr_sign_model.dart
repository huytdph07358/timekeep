import 'package:json_annotation/json_annotation.dart';
part 'emr_sign_model.g.dart';

@JsonSerializable()
class EmrSignModel {
  EmrSignModel();

  factory EmrSignModel.fromJson(Map<String, dynamic> json) =>
      _$EmrSignModelFromJson(json);

  int? ID;
  int? DOCUMENT_ID;
  int? IS_ACTIVE;
  int? FLOW_ID;
  String? FLOW_NAME;
  String? USERNAME;
  String? RELATION_NAME;
  String? LOGINNAME;
  String? RELATION_PEOPLE_NAME;
  String? CARD_CODE;
  String? VIR_PATIENT_NAME;
  String? TITLE;
  int? SIGN_TIME;
  int? IS_SIGNING;
  int? REJECT_TIME;
  String? COOR_Y_RECTANGLE;
  String? COOR_X_RECTANGLE;
  String? PAGE_NUMBER;
  String? MAX_PAGE_NUMBER;
  int? NUM_ORDER;

  Map<String, dynamic> toJson() => _$EmrSignModelToJson(this);
}
