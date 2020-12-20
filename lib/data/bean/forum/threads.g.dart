// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Threads _$ThreadsFromJson(Map<String, dynamic> json) {
  return Threads(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ThreadInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$ThreadsToJson(Threads instance) => <String, dynamic>{
      'list': instance.threads,
      'count': instance.count,
    };
