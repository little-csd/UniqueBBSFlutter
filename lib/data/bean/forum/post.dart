import 'package:UniqueBBSFlutter/data/bean/forum/post_info.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  PostInfo post;
  ThreadInfo thread;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post(this.post, this.thread);
}
