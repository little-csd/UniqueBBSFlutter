// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_forum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullForum _$FullForumFromJson(Map<String, dynamic> json) {
  return FullForum(
    json['id'] as String,
    json['name'] as String,
    json['threads'] as int,
    json['icon'] as String,
    json['description'] as String,
    json['lastPost'] == null
        ? null
        : PostInfo.fromJson(json['lastPost'] as Map<String, dynamic>),
    json['lastPostInfo'] == null
        ? null
        : LastPost.fromJson(json['lastPostInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FullForumToJson(FullForum instance) => <String, dynamic>{
      'id': instance.fid,
      'name': instance.name,
      'threads': instance.threadCount,
      'icon': instance.icon,
      'description': instance.description,
      'lastPost': instance.lastPost,
      'lastPostInfo': instance.lastPostInfo,
    };
