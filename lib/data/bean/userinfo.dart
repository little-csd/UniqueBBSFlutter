import 'package:json_annotation/json_annotation.dart';

part 'userinfo.g.dart';

@JsonSerializable()
class UserInfo {
  int joinTime;
  String lastLogin;
  String qq;
  bool isAdmin;
  String avatar;
  String email;
  String username;
  int spaceQuota;
  String dormitory;
  String signature;
  String id;
  String className;
  String wechat;
  String mobile;
  int threads;
  String major;
  String studentID;
  bool active;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo(
      this.joinTime,
      this.lastLogin,
      this.qq,
      this.isAdmin,
      this.avatar,
      this.email,
      this.username,
      this.spaceQuota,
      this.dormitory,
      this.signature,
      this.id,
      this.className,
      this.wechat,
      this.mobile,
      this.threads,
      this.major,
      this.studentID,
      this.active);
}
