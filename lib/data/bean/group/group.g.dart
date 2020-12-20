// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    json['info'] == null
        ? null
        : GroupInfo.fromJson(json['info'] as Map<String, dynamic>),
    json['master'] == null
        ? null
        : UserInfo.fromJson(json['master'] as Map<String, dynamic>),
    json['count'] as int,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'info': instance.info,
      'master': instance.master,
      'count': instance.count,
    };
