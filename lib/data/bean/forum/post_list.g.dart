// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostList _$PostListFromJson(Map<String, dynamic> json) {
  return PostList(
    json['threadInfo'] == null
        ? null
        : ThreadInfo.fromJson(json['threadInfo'] as Map<String, dynamic>),
    json['threadAuthor'] == null
        ? null
        : UserInfo.fromJson(json['threadAuthor'] as Map<String, dynamic>),
    json['firstPost'] == null
        ? null
        : PostInfo.fromJson(json['firstPost'] as Map<String, dynamic>),
    (json['postArr'] as List)
        ?.map((e) =>
            e == null ? null : PostData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attachArr'] as List)
        ?.map((e) =>
            e == null ? null : AttachData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['forumInfo'] == null
        ? null
        : BasicForum.fromJson(json['forumInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostListToJson(PostList instance) => <String, dynamic>{
      'threadInfo': instance.threadInfo,
      'threadAuthor': instance.threadAuthor,
      'firstPost': instance.firstPost,
      'postArr': instance.postArr,
      'attachArr': instance.attachArr,
      'forumInfo': instance.forumInfo,
    };
