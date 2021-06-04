import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/forum/post_info.dart';
import 'package:unique_bbs/data/bean/group/group_info.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';

part 'post_data.g.dart';

@JsonSerializable()
class PostData {
  PostInfo post;
  UserInfo user;
  List<GroupInfo> group;
  PostInfo quote;

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);
  Map<String, dynamic> toJson() => _$PostDataToJson(this);

  PostData(this.post, this.user, this.group, this.quote);
}
