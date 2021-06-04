import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/forum/thread_info.dart';

part 'user_thread.g.dart';

@JsonSerializable()
class UserThread {
  @JsonKey(name: 'list')
  List<ThreadInfo> threads;
  int count;

  factory UserThread.fromJson(Map<String, dynamic> json) =>
      _$UserThreadFromJson(json);
  Map<String, dynamic> toJson() => _$UserThreadToJson(this);

  UserThread(this.threads, this.count);
}
