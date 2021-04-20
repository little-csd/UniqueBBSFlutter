// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
    json['id'] as String?,
    json['message'] as String?,
    json['createDate'] as String?,
    json['isWeek'] as bool?,
  );
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.rid,
      'message': instance.message,
      'createDate': instance.createDate,
      'isWeek': instance.isWeek,
    };
