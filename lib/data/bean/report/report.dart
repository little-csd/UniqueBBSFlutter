import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  @JsonKey(name: 'id')
  String? rid;
  String? message;
  String? createDate;
  bool? isWeek;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);

  Report(this.rid, this.message, this.createDate, this.isWeek);
}
