import 'package:json_annotation/json_annotation.dart';
import 'package:vss_date_time_util/date_time_util.dart';

import 'emr_sign_model.dart';

@JsonSerializable()
class EmrDocumentFileModel {
  EmrDocumentFileModel();

  int? IS_MULTI_SIGN;
  String? Base64Data;
  int? DocumentId;
  double? DocumentWidth;
  double? DocumentHeight;
  List<EmrSignModel>? PointSigns;

  factory EmrDocumentFileModel.fromJson(Map<String, dynamic> json) =>
      EmrDocumentFileModel()
        ..IS_MULTI_SIGN = json['IS_MULTI_SIGN'] as int?
        ..DocumentId = json['DocumentId'] as int?
        ..DocumentWidth = json['DocumentWidth'] as double?
        ..DocumentHeight = json['DocumentHeight'] as double?
        ..PointSigns = json["PointSigns"] != null
            ? List<EmrSignModel>.from(
                json["PointSigns"]?.map((x) => EmrSignModel.fromJson(x)) ?? [])
            : null
        ..Base64Data = json['Base64Data'] as String?;

  Map<String, dynamic> toJson(EmrDocumentFileModel instance) =>
      <String, dynamic>{
        'DocumentId': instance.DocumentId,
        'DocumentWidth': instance.DocumentWidth,
        'DocumentHeight': instance.DocumentHeight,
        'Base64Data': instance.Base64Data,
        'PointSigns': instance.PointSigns != null
            ? List<EmrSignModel>.from(
                instance.PointSigns!.map((EmrSignModel x) => x.toJson()))
            : null,
      };
}
