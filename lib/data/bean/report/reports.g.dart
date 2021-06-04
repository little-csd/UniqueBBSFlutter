// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reports _$ReportsFromJson(Map<String, dynamic> json) {
  return Reports(
    (json['list'] as List<dynamic>)
        .map((e) => Report.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$ReportsToJson(Reports instance) => <String, dynamic>{
      'list': instance.reports,
      'count': instance.count,
    };
