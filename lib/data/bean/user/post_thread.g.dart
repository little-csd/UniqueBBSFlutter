// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostThread _$PostThreadFromJson(Map<String, dynamic> json) {
  return PostThread(
    PostInfo.fromJson(json['post'] as Map<String, dynamic>),
    ThreadInfo.fromJson(json['thread'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostThreadToJson(PostThread instance) =>
    <String, dynamic>{
      'post': instance.post,
      'thread': instance.thread,
    };
