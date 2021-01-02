import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user_info.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/widget/common/common_avatar.dart';
import 'package:flutter/material.dart';

const _topText = "TOP";
const _hotText = "HOT";
const _newText = "NEW";
const _publish = "发布";
const _avatarTextPadding = 8.0;
const _textWidgetWidth = 35.0;
final _messageTextStyle = TextStyle(
  color: ColorConstant.textGrey,
  fontSize: 12,
  fontWeight: FontWeight.bold,
);
final _subjectTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

_buildTextWidget(String text) => Container(
      width: _textWidgetWidth,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstant.textBackgroundLightPurple,
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 10,
            color: ColorConstant.textWhite,
            fontWeight: FontWeight.bold),
      ),
    );

_buildLimitWidthText(String text, TextStyle style, double maxWidth) =>
    Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Text(
          text,
          style: style,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ));

class ThreadItem extends StatelessWidget {
  final String subject;
  final String message;

  final ThreadInfo data;
  final UserInfo creator;
  final bool isNew;

  ThreadItem(this.data, this.creator, {this.isNew = false})
      : subject = data.subject,
        message = getDayString(data.createDate) +
            " " +
            creator.username +
            " " +
            _publish;

  /// 计算标题需要留的宽度(减去 hot/new/top 等标识)
  double computeTextOffset() {
    final count =
        (data.diamond ? 1 : 0) + (data.top > 0 ? 1 : 0) + (isNew ? 1 : 0);
    return count * _textWidgetWidth;
  }

  @override
  Widget build(BuildContext context) {
    if (data.closed) return Container();
    final maxTextWidth = MediaQuery.of(context).size.width - 150;
    double maxTitleWidth = maxTextWidth - computeTextOffset();
    return GestureDetector(
      onTap: () {
        Thread thread = Thread(data, creator, []);
        Navigator.of(context).pushNamed(BBSRoute.postDetail, arguments: thread);
      },
      child: Row(
        children: <Widget>[
          BBSAvatar(creator.avatar),
          Container(
            margin: EdgeInsets.only(left: _avatarTextPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  _buildLimitWidthText(
                      subject, _subjectTextStyle, maxTitleWidth),
                  if (data.top > 0) _buildTextWidget(_topText),
                  if (data.diamond) _buildTextWidget(_hotText),
                  if (isNew) _buildTextWidget(_newText),
                ]),
                _buildLimitWidthText(message, _messageTextStyle, maxTextWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
