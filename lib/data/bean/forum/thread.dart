import 'package:UniqueBBS/data/bean/forum/post_info.dart';
import 'package:UniqueBBS/data/bean/forum/thread_info.dart';
import 'package:UniqueBBS/data/bean/user/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@JsonSerializable()
class Thread {
  ThreadInfo thread;
  UserInfo user;
  List<PostInfo> lastReply;

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadToJson(this);

  Thread(this.thread, this.user, this.lastReply);
}
