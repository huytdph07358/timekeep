import 'package:json_annotation/json_annotation.dart';
import 'package:vss_date_time_util/date_time_util.dart';

part 'cos_people_model.g.dart';

@JsonSerializable()
class CosPeopleModel {
  CosPeopleModel();

  factory CosPeopleModel.fromJson(Map<String, dynamic> json) =>
      _$CosPeopleModelFromJson(json);

  int? Id;
  String? PeopleCode;
  String? FirstName;
  String? LastName;
  String? FullName;
  int? Dob;
  int? IsHasNotDayDob;
  String? GenderName;
  String? Phone;
  String? Email;
  String? CmndNumber;
  int? CmndDate;
  String? CmndPlace;
  String? AvatarUrl;
  String? CmndBeforeUrl;
  String? CmndAfterUrl;
  String? FullAddress;
  List<String>? CardCodes;

  Map<String, dynamic> toJson() => _$CosPeopleModelToJson(this);

  DateTime? getDateTimeDob() {
    return DateTimeUtil.parse(Dob);
  }

  DateTime? getDateTimeCmndDate() {
    return DateTimeUtil.parse(CmndDate);
  }
}
