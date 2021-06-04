import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/report/report.dart';

part 'reports.g.dart';

@JsonSerializable()
class Reports {
  @JsonKey(name: 'list')
  List<Report> reports;
  int count;

  factory Reports.fromJson(Map<String, dynamic> json) =>
      _$ReportsFromJson(json);
  Map<String, dynamic> toJson() => _$ReportsToJson(this);

  Reports(this.reports, this.count);
}
