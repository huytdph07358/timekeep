// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emr_document_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmrDocumentTypeModel _$EmrDocumentTypeModelFromJson(
        Map<String, dynamic> json) =>
    EmrDocumentTypeModel()
      ..ID = json['ID'] as int?
      ..MODIFY_TIME = json['MODIFY_TIME'] as int?
      ..CREATE_TIME = json['CREATE_TIME'] as int?
      ..DOCUMENT_TYPE_CODE = json['DOCUMENT_TYPE_CODE'] as String?
      ..DOCUMENT_TYPE_NAME = json['DOCUMENT_TYPE_NAME'] as String?
      ..NUM_ORDER = json['NUM_ORDER'] as int?
      ..IS_ACTIVE = json['IS_ACTIVE'] as int?
      ..IS_MULTI_SIGN = json['IS_MULTI_SIGN'] as int?;

Map<String, dynamic> _$EmrDocumentTypeModelToJson(
        EmrDocumentTypeModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'DOCUMENT_TYPE_CODE': instance.DOCUMENT_TYPE_CODE,
      'CREATE_TIME': instance.CREATE_TIME,
      'MODIFY_TIME': instance.MODIFY_TIME,
      'DOCUMENT_TYPE_NAME': instance.DOCUMENT_TYPE_NAME,
      'IS_MULTI_SIGN': instance.IS_MULTI_SIGN,
      'IS_ACTIVE': instance.IS_ACTIVE,
      'NUM_ORDER': instance.NUM_ORDER,
    };
