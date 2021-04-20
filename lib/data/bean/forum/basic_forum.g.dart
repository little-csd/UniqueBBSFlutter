// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_forum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicForum _$BasicForumFromJson(Map<String, dynamic> json) {
  return BasicForum(
    json['name'] as String?,
    json['description'] as String?,
    json['icon'] as String?,
    json['id'] as String?,
    json['threads'] as int?,
  );
}

Map<String, dynamic> _$BasicForumToJson(BasicForum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'id': instance.fid,
      'threads': instance.threadCount,
    };
