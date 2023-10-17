// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_sign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointSignModel _$PointSignModelFromJson(Map<String, dynamic> json) =>
    PointSignModel()
      ..SignId = json['SignId'] as int?
      ..DocumentId = json['DocumentId'] as int?
      ..CoorXRectangle = json['CoorXRectangle'] as double?
      ..CoorYRectangle = json['CoorYRectangle'] as double?
      ..PageNumber = json['PageNumber'] as int?
      ..MaxPageNumber = json['MaxPageNumber'] as int?;

Map<String, dynamic> _$PointSignModelToJson(PointSignModel instance) =>
    <String, dynamic>{
      'SignId': instance.SignId,
      'DocumentId': instance.DocumentId,
      'CoorXRectangle': instance.CoorXRectangle,
      'CoorYRectangle': instance.CoorYRectangle,
      'PageNumber': instance.PageNumber,
      'MaxPageNumber': instance.MaxPageNumber,
    };
