// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acs_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcsTokenModel _$AcsTokenModelFromJson(Map<String, dynamic> json) =>
    AcsTokenModel()
      ..LoginTime = json['LoginTime'] as String?
      ..RenewCode = json['RenewCode'] as String?
      ..TokenCode = json['TokenCode'] as String?
      ..ExpireTime = json['ExpireTime'] as String?
      ..LoginAddress = json['LoginAddress'] as String?
      ..VersionApp = json['VersionApp'] as String?
      ..MachineName = json['MachineName'] as String?
      ..LastAccessTime = json['LastAccessTime'] as String?
      ..AuthorSystemCode = json['AuthorSystemCode'] as String?
      ..AuthenticationCode = json['AuthenticationCode'] as String?
      ..User = json['User'] == null
          ? null
          : AcsUserModel.fromJson(json['User'] as Map<String, dynamic>);

Map<String, dynamic> _$AcsTokenModelToJson(AcsTokenModel instance) =>
    <String, dynamic>{
      'LoginTime': instance.LoginTime,
      'RenewCode': instance.RenewCode,
      'TokenCode': instance.TokenCode,
      'ExpireTime': instance.ExpireTime,
      'LoginAddress': instance.LoginAddress,
      'VersionApp': instance.VersionApp,
      'MachineName': instance.MachineName,
      'LastAccessTime': instance.LastAccessTime,
      'AuthorSystemCode': instance.AuthorSystemCode,
      'AuthenticationCode': instance.AuthenticationCode,
      'User': instance.User,
    };
