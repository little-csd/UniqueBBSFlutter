// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupInfo _$GroupInfoFromJson(Map<String, dynamic> json) {
  return GroupInfo(
    json['id'] as String,
    json['key'] as int,
    json['name'] as String,
    json['color'] as String,
  );
}

Map<String, dynamic> _$GroupInfoToJson(GroupInfo instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'color': instance.color,
    };
