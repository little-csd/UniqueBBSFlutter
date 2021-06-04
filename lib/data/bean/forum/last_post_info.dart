import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/forum/thread_info.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';

part 'last_post_info.g.dart';

@JsonSerializable()
class LastPostInfo {
  UserInfo user;
  ThreadInfo thread;

  factory LastPostInfo.fromJson(Map<String, dynamic> json) =>
      _$LastPostInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LastPostInfoToJson(this);

  LastPostInfo(this.user, this.thread);
}
