// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    json['joinTime'] as int,
    json['lastLogin'] as String,
    json['qq'] as String,
    json['isAdmin'] as bool,
    json['avatar'] as String,
    json['email'] as String,
    json['username'] as String,
    json['spaceQuota'] as int,
    json['dormitory'] as String,
    json['signature'] as String,
    json['id'] as String,
    json['className'] as String,
    json['wechat'] as String,
    json['mobile'] as String,
    json['threads'] as int,
    json['major'] as String,
    json['studentID'] as String,
    json['active'] as bool,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'joinTime': instance.joinTime,
      'lastLogin': instance.lastLogin,
      'qq': instance.qq,
      'isAdmin': instance.isAdmin,
      'avatar': instance.avatar,
      'email': instance.email,
      'username': instance.username,
      'spaceQuota': instance.spaceQuota,
      'dormitory': instance.dormitory,
      'signature': instance.signature,
      'id': instance.id,
      'className': instance.className,
      'wechat': instance.wechat,
      'mobile': instance.mobile,
      'threads': instance.threads,
      'major': instance.major,
      'studentID': instance.studentID,
      'active': instance.active,
    };
