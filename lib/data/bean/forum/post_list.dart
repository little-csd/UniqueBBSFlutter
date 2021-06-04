import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/forum/basic_forum.dart';
import 'package:unique_bbs/data/bean/forum/post_data.dart';
import 'package:unique_bbs/data/bean/forum/post_info.dart';
import 'package:unique_bbs/data/bean/forum/thread_info.dart';
import 'package:unique_bbs/data/bean/other/attach_data.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';

part 'post_list.g.dart';

@JsonSerializable()
class PostList {
  ThreadInfo threadInfo;
  UserInfo threadAuthor;
  PostInfo firstPost;
  List<PostData> postArr;
  List<AttachData> attachArr;
  BasicForum forumInfo;

  factory PostList.fromJson(Map<String, dynamic> json) =>
      _$PostListFromJson(json);
  Map<String, dynamic> toJson() => _$PostListToJson(this);

  PostList(this.threadInfo, this.threadAuthor, this.firstPost, this.postArr,
      this.attachArr, this.forumInfo);
}
