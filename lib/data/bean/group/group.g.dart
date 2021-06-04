// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    GroupInfo.fromJson(json['group'] as Map<String, dynamic>),
    UserInfo.fromJson(json['master'] as Map<String, dynamic>),
    json['count'] as int,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'group': instance.group,
      'master': instance.master,
      'count': instance.count,
    };
