import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user_info.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/widget/common/common_avatar.dart';
import 'package:flutter/material.dart';

const _publish = "发布";
const _broadcastRadius = 25.0;

// todo : 这里是直接复制的旧代码，需要重构
class ForumItem2 extends StatelessWidget {

  String subject;
  String message;

  ThreadInfo data;
  UserInfo creator;

  ForumItem2(this.data, this.creator);

  _initData() {
    subject = data.subject;
    message = getDayString(data.createDate) + " " +  creator.username + " " + _publish;
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return Row(
      children: <Widget>[
        BBSAvatar(
          creator.avatar,
          radius: _broadcastRadius,
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          height: 48,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 180,
                    child:
                    Text(
                      data.subject,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    " HOT",
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Text(
                message,
                style: TextStyle(
                  color: ColorConstant.textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}



