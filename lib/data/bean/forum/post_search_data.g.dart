// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_search_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSearchData _$PostSearchDataFromJson(Map<String, dynamic> json) {
  return PostSearchData(
    json['id'] as String,
    json['key'] as String,
    json['subject'] as String,
    UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    json['message'] as String,
    json['postCount'] as int,
    json['createDate'] as String,
    json['threadCreateDate'] as String,
  );
}

Map<String, dynamic> _$PostSearchDataToJson(PostSearchData instance) =>
    <String, dynamic>{
      'id': instance.tid,
      'key': instance.pid,
      'subject': instance.subject,
      'user': instance.user,
      'message': instance.message,
      'postCount': instance.postCount,
      'createDate': instance.createDate,
      'threadCreateDate': instance.threadCreateDate,
    };
