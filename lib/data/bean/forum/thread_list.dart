import 'package:UniqueBBS/data/bean/forum/basic_forum.dart';
import 'package:UniqueBBS/data/bean/forum/thread.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread_list.g.dart';

@JsonSerializable()
class ThreadList {
  @JsonKey(name: 'list')
  List<Thread> threads;
  BasicForum forum;

  factory ThreadList.fromJson(Map<String, dynamic> json) =>
      _$ThreadListFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadListToJson(this);

  ThreadList(this.threads, this.forum);
}
