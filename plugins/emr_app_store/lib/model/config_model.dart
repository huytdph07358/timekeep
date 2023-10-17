import 'dart:convert';

import './uris_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_model.g.dart';

@JsonSerializable()
class ConfigModel {
  ConfigModel();

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  String? HOSPITAL_CODE;
  UrisModel? HISPITAL_CONFIG;

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}
