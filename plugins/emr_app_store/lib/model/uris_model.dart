import 'package:json_annotation/json_annotation.dart';

part 'uris_model.g.dart';

@JsonSerializable()
class UrisModel {
  UrisModel();

  factory UrisModel.fromJson(Map<String, dynamic> json) =>
      _$UrisModelFromJson(json);

  String? acsuri;
  String? emruri;
  String? sdauri;

  Map<String, dynamic> toJson() => _$UrisModelToJson(this);
}
