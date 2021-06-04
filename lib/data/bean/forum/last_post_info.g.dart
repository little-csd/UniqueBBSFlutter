// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_post_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastPostInfo _$LastPostInfoFromJson(Map<String, dynamic> json) {
  return LastPostInfo(
    UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    ThreadInfo.fromJson(json['thread'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LastPostInfoToJson(LastPostInfo instance) =>
    <String, dynamic>{
      'user': instance.user,
      'thread': instance.thread,
    };
