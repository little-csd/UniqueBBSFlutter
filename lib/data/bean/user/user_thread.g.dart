// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserThread _$UserThreadFromJson(Map<String, dynamic> json) {
  return UserThread(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ThreadInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$UserThreadToJson(UserThread instance) =>
    <String, dynamic>{
      'list': instance.threads,
      'count': instance.count,
    };
