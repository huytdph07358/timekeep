// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) => ConfigModel()
  ..HOSPITAL_CODE = json['HOSPITAL_CODE'] as String?
  ..HISPITAL_CONFIG = json['HISPITAL_CONFIG'] != null
      ? UrisModel.fromJson(json['HISPITAL_CONFIG'])
      : null;

Map<String, dynamic> _$ConfigModelToJson(ConfigModel instance) =>
    <String, dynamic>{
      'HOSPITAL_CODE': instance.HOSPITAL_CODE,
      'HISPITAL_CONFIG': instance.HISPITAL_CONFIG != null
          ? instance.HISPITAL_CONFIG!.toJson()
          : null,
    };
