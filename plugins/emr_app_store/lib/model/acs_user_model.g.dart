// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acs_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcsUserModel _$AcsUserModelFromJson(Map<String, dynamic> json) => AcsUserModel()
  ..LoginName = json['LoginName'] as String?
  ..UserName = json['UserName'] as String?
  ..ApplicationCode = json['ApplicationCode'] as String?
  ..GCode = json['GCode'] as String?
  ..Email = json['Email'] as String?
  ..Mobile = json['Mobile'] as String?;

Map<String, dynamic> _$AcsUserModelToJson(AcsUserModel instance) =>
    <String, dynamic>{
      'LoginName': instance.LoginName,
      'UserName': instance.UserName,
      'ApplicationCode': instance.ApplicationCode,
      'GCode': instance.GCode,
      'Email': instance.Email,
      'Mobile': instance.Mobile,
    };
