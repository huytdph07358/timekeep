import 'package:json_annotation/json_annotation.dart';
import 'package:vss_date_time_util/date_time_util.dart';

import 'point_sign_model.dart';

@JsonSerializable()
class DocumentSignModel {
  DocumentSignModel();

  int? DocumentTypeId;
  int? IS_MULTI_SIGN;
  String? Base64Data;
  int? DocumentId;
  double? DocumentWidth;
  double? DocumentHeight;
  List<PointSignModel>? PointSigns;
  String? Description;

  factory DocumentSignModel.fromJson(Map<String, dynamic> json) =>
      DocumentSignModel()
        ..DocumentTypeId = json['DocumentTypeId'] as int?
        ..IS_MULTI_SIGN = json['IS_MULTI_SIGN'] as int?
        ..DocumentId = json['DocumentId'] as int?
        ..DocumentWidth = json['DocumentWidth'] as double?
        ..DocumentHeight = json['DocumentHeight'] as double?
        ..PointSigns = json["PointSigns"] != null
            ? List<PointSignModel>.from(
                json["PointSigns"]?.map((x) => PointSignModel.fromJson(x)) ??
                    [])
            : null
        ..Description = json['Description'] as String
        ..Base64Data = json['Base64Data'] as String?;

  Map<String, dynamic> toJson(DocumentSignModel instance) => <String, dynamic>{
        'DocumentTypeId': instance.DocumentTypeId,
        'IS_MULTI_SIGN': instance.IS_MULTI_SIGN,
        'DocumentId': instance.DocumentId,
        'DocumentWidth': instance.DocumentWidth,
        'DocumentHeight': instance.DocumentHeight,
        'Base64Data': instance.Base64Data,
        'Description': instance.Description,
        'PointSigns': instance.PointSigns != null
            ? List<PointSignModel>.from(
                instance.PointSigns!.map((PointSignModel x) => x.toJson()))
            : null,
      };
}
