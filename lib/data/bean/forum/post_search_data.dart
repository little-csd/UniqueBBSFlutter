import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';

part 'post_search_data.g.dart';

@JsonSerializable()
class PostSearchData {
  @JsonKey(name: 'id')
  String tid;
  @JsonKey(name: 'key')
  String pid;
  String subject;
  UserInfo user;
  String message;
  int postCount;
  String createDate;
  String threadCreateDate;

  factory PostSearchData.fromJson(Map<String, dynamic> json) =>
      _$PostSearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$PostSearchDataToJson(this);

  PostSearchData(this.tid, this.pid, this.subject, this.user, this.message,
      this.postCount, this.createDate, this.threadCreateDate);
}
