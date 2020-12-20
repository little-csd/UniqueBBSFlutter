import 'package:UniqueBBSFlutter/data/bean/forum/post_info.dart';
import 'package:json_annotation/json_annotation.dart';

import 'last_post.dart';

part 'full_forum.g.dart';

@JsonSerializable()
class FullForum {
  @JsonKey(name: 'id')
  String fid;
  String name;
  @JsonKey(name: 'threads')
  int threadCount;
  String icon;
  String description;
  // 这里 last post 包含最后一个 post 的信息
  PostInfo lastPost;
  // lastPostInfo 包含最后一个 post 所在的 thread 以及 user 信息
  LastPost lastPostInfo;

  factory FullForum.fromJson(Map<String, dynamic> json) =>
      _$FullForumFromJson(json);
  Map<String, dynamic> toJson() => _$FullForumToJson(this);

  FullForum(this.fid, this.name, this.threadCount, this.icon, this.description,
      this.lastPost, this.lastPostInfo);
}
