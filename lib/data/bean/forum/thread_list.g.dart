// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThreadList _$ThreadListFromJson(Map<String, dynamic> json) {
  return ThreadList(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Thread.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['forum'] == null
        ? null
        : BasicForum.fromJson(json['forum'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ThreadListToJson(ThreadList instance) =>
    <String, dynamic>{
      'list': instance.threads,
      'forum': instance.forum,
    };
