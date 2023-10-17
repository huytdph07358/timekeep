// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emr_sign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmrSignModel _$EmrSignModelFromJson(Map<String, dynamic> json) => EmrSignModel()
  ..ID = json['ID'] as int?
  ..DOCUMENT_ID = json['DOCUMENT_ID'] as int?
  ..IS_ACTIVE = json['IS_ACTIVE'] as int?
  ..FLOW_ID = json['FLOW_ID '] as int?
  ..FLOW_NAME = json['FLOW_NAME'] as String?
  ..USERNAME = json['USERNAME '] as String?
  ..RELATION_NAME = json['RELATION_NAME'] as String?
  ..RELATION_PEOPLE_NAME = json['RELATION_PEOPLE_NAME'] as String?
  ..CARD_CODE = json['CARD_CODE'] as String?
  ..VIR_PATIENT_NAME = json['rowNum'] as String?
  ..TITLE = json['TITLE'] as String?
  ..SIGN_TIME = json['SIGN_TIME '] as int?
  ..IS_SIGNING = json['IS_SIGNING'] as int?
  ..REJECT_TIME = json['REJECT_TIME'] as int?;

Map<String, dynamic> _$EmrSignModelToJson(EmrSignModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'DOCUMENT_ID': instance.DOCUMENT_ID,
      'IS_ACTIVE': instance.IS_ACTIVE,
      'FLOW_ID ': instance.FLOW_ID,
      'FLOW_NAME': instance.FLOW_NAME,
      'USERNAME ': instance.USERNAME,
      'RELATION_NAME': instance.RELATION_NAME,
      'RELATION_PEOPLE_NAME': instance.RELATION_PEOPLE_NAME,
      'CARD_CODE': instance.CARD_CODE,
      'VIR_PATIENT_NAME': instance.VIR_PATIENT_NAME,
      'TITLE': instance.TITLE,
      'SIGN_TIME ': instance.SIGN_TIME,
      'IS_SIGNING': instance.IS_SIGNING,
      'REJECT_TIME': instance.REJECT_TIME,
    };
