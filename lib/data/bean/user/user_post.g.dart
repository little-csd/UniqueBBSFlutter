// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPost _$UserPostFromJson(Map<String, dynamic> json) {
  return UserPost(
    (json['list'] as List)
        ?.map((e) =>
            e == null ? null : PostThread.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$UserPostToJson(UserPost instance) => <String, dynamic>{
      'list': instance.posts,
      'count': instance.count,
    };
