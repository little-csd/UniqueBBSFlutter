// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupUsers _$GroupUsersFromJson(Map<String, dynamic> json) {
  return GroupUsers(
    (json['list'] as List?)
        ?.map((e) =>
            e == null ? null : UserInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : GroupInfo.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupUsersToJson(GroupUsers instance) =>
    <String, dynamic>{
      'list': instance.users,
      'info': instance.info,
    };
