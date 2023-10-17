import 'package:json_annotation/json_annotation.dart';

import 'acs_user_model.dart';

part 'acs_token_model.g.dart';

@JsonSerializable()
class AcsTokenModel {
  AcsTokenModel();

  factory AcsTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AcsTokenModelFromJson(json);

  String? LoginTime;
  String? RenewCode;
  String? TokenCode;
  String? ExpireTime;
  String? LoginAddress;
  String? VersionApp;
  String? MachineName;
  String? LastAccessTime;
  String? AuthorSystemCode;
  String? AuthenticationCode;
  AcsUserModel? User;

  Map<String, dynamic> toJson() => _$AcsTokenModelToJson(this);
}
