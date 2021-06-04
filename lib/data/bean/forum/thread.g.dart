// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) {
  return Thread(
    ThreadInfo.fromJson(json['thread'] as Map<String, dynamic>),
    UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    (json['lastReply'] as List<dynamic>)
        .map((e) => PostInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'thread': instance.thread,
      'user': instance.user,
      'lastReply': instance.lastReply,
    };
