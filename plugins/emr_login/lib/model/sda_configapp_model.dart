import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SdaConfigappModel {
  SdaConfigappModel();

  int? ID;
  int? CREATE_TIME;
  int? MODIFY_TIME;
  String? CREATOR;
  String? MODIFIER;
  String? APP_CREATOR;
  String? APP_MODIFIER;
  int? IS_ACTIVE;
  int? IS_DELETE;
  String? GROUP_CODE;
  String? KEY;
  // String? DEFAULT_VALUE;
  String? DEFAULT_VALUE;

  factory SdaConfigappModel.fromJson(Map<String, dynamic> json) =>
      SdaConfigappModel()
        ..ID = json['ID'] as int?
        ..CREATE_TIME = json['CREATE_TIME'] as int?
        ..MODIFY_TIME = json['MODIFY_TIME'] as int?
        ..CREATOR = json['CREATOR'] as String?
        ..DEFAULT_VALUE = json["DEFAULT_VALUE"] as String?
        // != null
        //     ? List<UriModel>.from(json["DEFAULT_VALUE"]
        //             ?.map((x) => UriModel.fromJson(x)) ??
        //         [])
        //     : null
        ..MODIFIER = json['MODIFIER'] as String?
        ..APP_CREATOR = json['APP_CREATOR'] as String?
        ..APP_MODIFIER = json['APP_MODIFIER'] as String?
        ..IS_ACTIVE = json['IS_ACTIVE'] as int?
        ..IS_DELETE = json['IS_DELETE'] as int?
        ..GROUP_CODE = json['GROUP_CODE'] as String?
        ..KEY = json['KEY'] as String?;

  Map<String, dynamic> toJson(SdaConfigappModel instance) => <String, dynamic>{
        'ID': instance.ID,
        'CREATE_TIME': instance.CREATE_TIME,
        'MODIFY_TIME': instance.MODIFY_TIME,
        'CREATOR': instance.CREATOR,
        'MODIFIER': instance.MODIFIER,
        'APP_CREATOR': instance.APP_CREATOR,
        'APP_MODIFIER': instance.APP_MODIFIER,
        'IS_ACTIVE': instance.IS_ACTIVE,
        'IS_DELETE': instance.IS_DELETE,
        'GROUP_CODE': instance.GROUP_CODE,
        'KEY': instance.KEY,
        'DEFAULT_VALUE': instance.DEFAULT_VALUE,
        // != null

        //     ? List<UriModel>.from(
        //         instance.DEFAULT_VALUE!.map((UriModel x) => x.toJson()))
        //     : null,
      };
}
