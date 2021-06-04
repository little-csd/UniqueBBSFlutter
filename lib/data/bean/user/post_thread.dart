import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/forum/post_info.dart';
import 'package:unique_bbs/data/bean/forum/thread_info.dart';

part 'post_thread.g.dart';

@JsonSerializable()
class PostThread {
  PostInfo post;
  ThreadInfo thread;

  factory PostThread.fromJson(Map<String, dynamic> json) =>
      _$PostThreadFromJson(json);
  Map<String, dynamic> toJson() => _$PostThreadToJson(this);

  PostThread(this.post, this.thread);
}
