// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastPost _$LastPostFromJson(Map<String, dynamic> json) {
  return LastPost(
    json['user'] == null
        ? null
        : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    json['thread'] == null
        ? null
        : ThreadInfo.fromJson(json['thread'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LastPostToJson(LastPost instance) => <String, dynamic>{
      'user': instance.user,
      'thread': instance.thread,
    };
