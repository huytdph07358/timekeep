// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvb_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvbScreenModel _$TvbScreenModelFromJson(Map<String, dynamic> json) =>
    TvbScreenModel()
      ..id = json['id'] as String?
      ..screenName = json['screenName'] as String?
      ..screenLink = json['screenLink'] as String?
      ..icon = json['icon'] as int?
      ..isMenu = json['isMenu'] as bool?
      ..isAnonymous = json['isAnonymous'] as bool?
      ..arguments = json['arguments'] as Map<String, dynamic>?
      ..names = (json['names'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..roles =
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$TvbScreenModelToJson(TvbScreenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'screenName': instance.screenName,
      'screenLink': instance.screenLink,
      'icon': instance.icon,
      'isMenu': instance.isMenu,
      'isAnonymous': instance.isAnonymous,
      'arguments': instance.arguments,
      'names': instance.names,
      'roles': instance.roles,
    };
