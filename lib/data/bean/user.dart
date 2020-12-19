import 'package:UniqueBBSFlutter/data/bean/groupinfo.dart';
import 'package:UniqueBBSFlutter/data/bean/userinfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  UserInfo user;
  @JsonKey(name: 'group')
  List<GroupInfo> groups;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User(this.user, this.groups);
}
