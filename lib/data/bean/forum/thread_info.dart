import 'package:json_annotation/json_annotation.dart';

part 'thread_info.g.dart';

@JsonSerializable()
class ThreadInfo {
  int postCount;
  String subject;
  String createDate;
  bool closed;
  @JsonKey(name: 'id')
  String tid;
  String lastDate;
  bool diamond;
  int top;
  bool active;

  factory ThreadInfo.fromJson(Map<String, dynamic> json) =>
      _$ThreadInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadInfoToJson(this);

  ThreadInfo(this.postCount, this.subject, this.createDate, this.closed,
      this.tid, this.lastDate, this.diamond, this.top, this.active);
}
