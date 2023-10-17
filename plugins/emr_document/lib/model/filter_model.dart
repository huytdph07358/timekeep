import 'package:flutter/cupertino.dart';

class FilterModel {
  FilterModel({
    this.documentTypeName,
    this.totalDays,
    this.documentTypeId,
    this.fromDate,
    this.toDate,
  });
  String? documentTypeName;
  String? totalDays;
  int? documentTypeId;
  DateTime? fromDate;
  DateTime? toDate;
}
