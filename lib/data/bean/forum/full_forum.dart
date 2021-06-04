import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/forum/post_info.dart';

import 'last_post_info.dart';

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
  LastPostInfo lastPostInfo;

  factory FullForum.fromJson(Map<String, dynamic> json) =>
      _$FullForumFromJson(json);
  Map<String, dynamic> toJson() => _$FullForumToJson(this);

  FullForum(this.fid, this.name, this.threadCount, this.icon, this.description,
      this.lastPost, this.lastPostInfo);
}
