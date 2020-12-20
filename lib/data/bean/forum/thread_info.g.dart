// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadInfo _$ThreadInfoFromJson(Map<String, dynamic> json) {
  return ThreadInfo(
    json['postCount'] as int,
    json['subject'] as String,
    json['createDate'] as String,
    json['closed'] as bool,
    json['id'] as String,
    json['lastDate'] as String,
    json['diamond'] as bool,
    json['top'] as int,
    json['active'] as bool,
  );
}

Map<String, dynamic> _$ThreadInfoToJson(ThreadInfo instance) =>
    <String, dynamic>{
      'postCount': instance.postCount,
      'subject': instance.subject,
      'createDate': instance.createDate,
      'closed': instance.closed,
      'id': instance.tid,
      'lastDate': instance.lastDate,
      'diamond': instance.diamond,
      'top': instance.top,
      'active': instance.active,
    };
