import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'threads.g.dart';

@JsonSerializable()
class Threads {
  @JsonKey(name: 'list')
  List<ThreadInfo> threads;
  int count;

  factory Threads.fromJson(Map<String, dynamic> json) =>
      _$ThreadsFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadsToJson(this);

  Threads(this.threads, this.count);
}
