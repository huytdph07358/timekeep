// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cos_people_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CosPeopleModel _$CosPeopleModelFromJson(Map<String, dynamic> json) =>
    CosPeopleModel()
      ..Id = json['Id'] as int?
      ..PeopleCode = json['PeopleCode'] as String?
      ..FirstName = json['FirstName'] as String?
      ..LastName = json['LastName'] as String?
      ..FullName = json['FullName'] as String?
      ..Dob = json['Dob'] as int?
      ..IsHasNotDayDob = json['IsHasNotDayDob'] as int?
      ..GenderName = json['GenderName'] as String?
      ..Phone = json['Phone'] as String?
      ..Email = json['Email'] as String?
      ..CmndNumber = json['CmndNumber'] as String?
      ..CmndDate = json['CmndDate'] as int?
      ..CmndPlace = json['CmndPlace'] as String?
      ..AvatarUrl = json['AvatarUrl'] as String?
      ..CmndBeforeUrl = json['CmndBeforeUrl'] as String?
      ..CmndAfterUrl = json['CmndAfterUrl'] as String?
      ..FullAddress = json['FullAddress'] as String?
      ..CardCodes = (json['CardCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

Map<String, dynamic> _$CosPeopleModelToJson(CosPeopleModel instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'PeopleCode': instance.PeopleCode,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'FullName': instance.FullName,
      'Dob': instance.Dob,
      'IsHasNotDayDob': instance.IsHasNotDayDob,
      'GenderName': instance.GenderName,
      'Phone': instance.Phone,
      'Email': instance.Email,
      'CmndNumber': instance.CmndNumber,
      'CmndDate': instance.CmndDate,
      'CmndPlace': instance.CmndPlace,
      'AvatarUrl': instance.AvatarUrl,
      'CmndBeforeUrl': instance.CmndBeforeUrl,
      'CmndAfterUrl': instance.CmndAfterUrl,
      'FullAddress': instance.FullAddress,
      'CardCodes': instance.CardCodes,
    };
