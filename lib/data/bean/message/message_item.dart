import 'package:json_annotation/json_annotation.dart';

part 'message_item.g.dart';

@JsonSerializable()
class MessageItem {
  String? createDate;
  String? url;
  @JsonKey(name: 'id')
  String? mid;
  bool? isRead;
  String? message;

  factory MessageItem.fromJson(Map<String, dynamic> json) =>
      _$MessageItemFromJson(json);
  Map<String, dynamic> toJson() => _$MessageItemToJson(this);

  MessageItem(this.createDate, this.url, this.mid, this.isRead, this.message);
}
