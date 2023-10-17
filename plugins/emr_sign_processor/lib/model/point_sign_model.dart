import 'package:json_annotation/json_annotation.dart';
part 'point_sign_model.g.dart';

@JsonSerializable()
class PointSignModel {
  PointSignModel();

  factory PointSignModel.fromJson(Map<String, dynamic> json) =>
      _$PointSignModelFromJson(json);

  int? SignId;
  int? DocumentId;
  double? CoorXRectangle;
  double? CoorYRectangle;
  int? PageNumber;
  int? MaxPageNumber;
  Map<String, dynamic> toJson() => _$PointSignModelToJson(this);
}
