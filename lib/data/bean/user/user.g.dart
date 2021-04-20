// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['user'] == null
        ? null
        : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    (json['group'] as List?)
        ?.map((e) =>
            e == null ? null : GroupInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user': instance.user,
      'group': instance.groups,
    };
