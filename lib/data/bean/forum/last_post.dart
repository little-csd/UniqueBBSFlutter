import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_post.g.dart';

@JsonSerializable()
class LastPost {
  UserInfo user;
  ThreadInfo thread;

  factory LastPost.fromJson(Map<String, dynamic> json) =>
      _$LastPostFromJson(json);
  Map<String, dynamic> toJson() => _$LastPostToJson(this);

  LastPost(this.user, this.thread);
}
