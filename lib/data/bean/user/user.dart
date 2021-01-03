import 'package:UniqueBBS/data/bean/group/group_info.dart';
import 'package:UniqueBBS/data/bean/user/user_info.dart';
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
