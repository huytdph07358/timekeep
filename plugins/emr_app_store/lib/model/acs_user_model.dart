import 'package:json_annotation/json_annotation.dart';

part 'acs_user_model.g.dart';

@JsonSerializable()
class AcsUserModel {
  AcsUserModel();

  factory AcsUserModel.fromJson(Map<String, dynamic> json) =>
      _$AcsUserModelFromJson(json);

  String? LoginName;
  String? UserName;
  String? ApplicationCode;
  String? GCode;
  String? Email;
  String? Mobile;

  Map<String, dynamic> toJson() => _$AcsUserModelToJson(this);
}
