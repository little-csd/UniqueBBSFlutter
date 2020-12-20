// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['post'] == null
        ? null
        : PostInfo.fromJson(json['post'] as Map<String, dynamic>),
    json['thread'] == null
        ? null
        : ThreadInfo.fromJson(json['thread'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'post': instance.post,
      'thread': instance.thread,
    };
