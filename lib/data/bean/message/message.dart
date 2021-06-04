import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/message/message_item.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  MessageItem messageItem;
  UserInfo fromUser;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message(this.messageItem, this.fromUser);
}
