// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostList _$PostListFromJson(Map<String, dynamic> json) {
  return PostList(
    ThreadInfo.fromJson(json['threadInfo'] as Map<String, dynamic>),
    UserInfo.fromJson(json['threadAuthor'] as Map<String, dynamic>),
    PostInfo.fromJson(json['firstPost'] as Map<String, dynamic>),
    (json['postArr'] as List<dynamic>)
        .map((e) => PostData.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['attachArr'] as List<dynamic>)
        .map((e) => AttachData.fromJson(e as Map<String, dynamic>))
        .toList(),
    BasicForum.fromJson(json['forumInfo'] as Map<String, dynamic>),
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
