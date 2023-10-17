import 'package:json_annotation/json_annotation.dart';

part 'tvb_screen_model.g.dart';

@JsonSerializable()
class TvbScreenModel {
  TvbScreenModel();

  factory TvbScreenModel.fromJson(Map<String, dynamic> json) =>
      _$TvbScreenModelFromJson(json);

  String? id;
  String? screenName;
  String? screenLink;
  int? icon;
  bool? isMenu;
  bool? isAnonymous;
  Map<String, dynamic>? arguments;
  Map<String, String?>? names;
  List<String>? roles;

  Map<String, dynamic> toJson() => _$TvbScreenModelToJson(this);
}
