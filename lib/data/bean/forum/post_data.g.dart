// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostData _$PostDataFromJson(Map<String, dynamic> json) {
  return PostData(
    PostInfo.fromJson(json['post'] as Map<String, dynamic>),
    UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    (json['group'] as List<dynamic>)
        .map((e) => GroupInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['quote'] == null
        ? null
        : PostInfo.fromJson(json['quote'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'post': instance.post,
      'user': instance.user,
      'group': instance.group,
      'quote': instance.quote,
    };
