// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emr_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmrDocumentModel _$EmrDocumentModelFromJson(Map<String, dynamic> json) =>
    EmrDocumentModel()
      ..ID = json['ID'] as int?
      ..MODIFY_TIME = json['MODIFY_TIME'] as int?
      ..CREATE_TIME = json['CREATE_TIME'] as int?
      ..DOCUMENT_TYPE_CODE = json['DOCUMENT_TYPE_CODE'] as String?
      ..DOCUMENT_TYPE_NAME = json['DOCUMENT_TYPE_NAME'] as String?
      ..DOCUMENT_TYPE_ID = json['DOCUMENT_TYPE_ID'] as int?
      ..DOCUMENT_CODE = json['DOCUMENT_CODE'] as String?
      ..DOCUMENT_NAME = json['DOCUMENT_NAME'] as String?
      ..DEPARTMENT_NAME = json['DEPARTMENT_NAME'] as String?
      ..VIR_PATIENT_NAME = json['VIR_PATIENT_NAME'] as String?
      ..PATIENT_CODE = json['PATIENT_CODE'] as String?
      ..TREATMENT_CODE = json['TREATMENT_CODE'] as String?
      ..IS_ACTIVE = json['IS_ACTIVE'] as int?
      ..IS_MULTI_SIGN = json['IS_MULTI_SIGN'] as int?
      ..GENDER_NAME = json['GENDER_NAME'] as String?
      ..REQUEST_LOGINNAME = json['REQUEST_LOGINNAME'] as String?
      ..REQUEST_USERNAME = json['REQUEST_USERNAME'] as String?
      ..DOB = json['DOB'] as int?
      ..DocumentWidth = json['DocumentWidth'] as double?
      ..DocumentHeight = json['DocumentHeight'] as double?
      ..Base64Data = json['Base64Data'] as String?;

Map<String, dynamic> _$EmrDocumentModelToJson(EmrDocumentModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'DOCUMENT_TYPE_CODE': instance.DOCUMENT_TYPE_CODE,
      'CREATE_TIME': instance.CREATE_TIME,
      'MODIFY_TIME': instance.MODIFY_TIME,
      'DOCUMENT_TYPE_NAME': instance.DOCUMENT_TYPE_NAME,
      'DOCUMENT_TYPE_ID': instance.DOCUMENT_TYPE_ID,
      'DOCUMENT_CODE': instance.DOCUMENT_CODE,
      'DOCUMENT_NAME': instance.DOCUMENT_NAME,
      'DEPARTMENT_NAME': instance.DEPARTMENT_NAME,
      'VIR_PATIENT_NAME': instance.VIR_PATIENT_NAME,
      'IS_MULTI_SIGN': instance.IS_MULTI_SIGN,
      'PATIENT_CODE': instance.PATIENT_CODE,
      'TREATMENT_CODE': instance.TREATMENT_CODE,
      'IS_ACTIVE': instance.IS_ACTIVE,
      'GENDER_NAME': instance.GENDER_NAME,
      'REQUEST_LOGINNAME': instance.REQUEST_LOGINNAME,
      'REQUEST_USERNAME': instance.REQUEST_USERNAME,
      'DOB': instance.DOB,
      'Base64Data': instance.Base64Data,
      'DocumentWidth': instance.DocumentWidth,
      'DocumentHeight': instance.DocumentHeight,
    };
