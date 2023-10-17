import 'package:json_annotation/json_annotation.dart';

import 'emr_sign_model.dart';
import 'point_sign_model.dart';

@JsonSerializable()
class EmrDocumentWaterMarkModel {
  EmrDocumentWaterMarkModel();

  int? IS_MULTI_SIGN;
  String? Base64Data;
  int? DocumentId;
  double? DocumentWidth;
  double? DocumentHeight;
  List<PointSignWateModel>? PointSigns;
  String? TextString;

  factory EmrDocumentWaterMarkModel.fromJson(Map<String, dynamic> json) =>
      EmrDocumentWaterMarkModel()
        ..IS_MULTI_SIGN = json['IS_MULTI_SIGN'] as int?
        ..DocumentId = json['DocumentId'] as int?
        ..DocumentWidth = json['DocumentWidth'] as double?
        ..DocumentHeight = json['DocumentHeight'] as double?
        ..PointSigns = json["PointSigns"] != null
            ? List<PointSignWateModel>.from(
                json["PointSigns"]?.map((x) => PointSignWateModel.fromJson(x)) ?? [])
            : null
        ..Base64Data = json['Base64Data'] as String?
        ..TextString = json['TextString'] as String?;

  Map<String, dynamic> toJson(EmrDocumentWaterMarkModel instance) =>
      <String, dynamic>{
        'DocumentId': instance.DocumentId,
        'DocumentWidth': instance.DocumentWidth,
        'DocumentHeight': instance.DocumentHeight,
        'Base64Data': instance.Base64Data,
        'TextString': instance.TextString,
        'PointSigns': instance.PointSigns != null
            ? List<PointSignWateModel>.from(
                instance.PointSigns!.map((PointSignWateModel x) => x.toJson()))
            : null,
      };
}
