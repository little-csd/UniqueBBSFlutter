import 'package:UniqueBBS/data/bean/forum/thread_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_thread.g.dart';

@JsonSerializable()
class UserThread {
  @JsonKey(name: 'list')
  List<ThreadInfo?>? threads;
  int? count;

  factory UserThread.fromJson(Map<String, dynamic> json) =>
      _$UserThreadFromJson(json);
  Map<String, dynamic> toJson() => _$UserThreadToJson(this);

  UserThread(this.threads, this.count);
}
