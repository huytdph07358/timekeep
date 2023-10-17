import 'package:json_annotation/json_annotation.dart';
part 'point_sign_model.g.dart';

@JsonSerializable()
class PointSignWateModel {
  PointSignWateModel();

  factory PointSignWateModel.fromJson(Map<String, dynamic> json) =>
      _$PointSignWateModelFromJson(json);

  int? SignId;
  int? DocumentId;
  double? CoorXRectangle;
  double? CoorYRectangle;
  int? PageNumber;
  int? MaxPageNumber;
  Map<String, dynamic> toJson() => _$PointSignWateModelToJson(this);
}
