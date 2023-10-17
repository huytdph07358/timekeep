import 'package:json_annotation/json_annotation.dart';

part 'vtx_role_model.g.dart';

@JsonSerializable()
class VtxRoleModel {
  VtxRoleModel();

  factory VtxRoleModel.fromJson(Map<String, dynamic> json) =>
      _$VtxRoleModelFromJson(json);

  String? roleCode;
  String? roleName;

  Map<String, dynamic> toJson() => _$VtxRoleModelToJson(this);
}
