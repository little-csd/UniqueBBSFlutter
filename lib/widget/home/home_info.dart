import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/config/route.dart';
import 'package:unique_bbs/data/bean/forum/full_forum.dart';
import 'package:unique_bbs/data/model/forum_model.dart';
import 'package:unique_bbs/tool/helper.dart';
import 'package:unique_bbs/tool/ui_helper.dart';
import 'package:unique_bbs/widget/common/common_avatar.dart';

const _mainHorizontalPadding = 20.0;
const _mainVerticalPadding = 10.0;

// 通知公告部分常量
const _broadcastHeight = 125.0;
const _innerHorizontalPadding = 15.0;
const _innerVerticalPadding = 10.0;
const _smallIconSize = 15.0;
const _broadcastAvatarRadius = 25.0;
const _titleSubtitleOffset = 3.0;
const _broadcastHeadTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: ColorConstant.textLightBlack,
  letterSpacing: 1.5,
);
const _titleStyle = TextStyle(
  fontSize: 16,
  color: ColorConstant.textBlack,
);
const _subtitleStyle = TextStyle(
  fontSize: 12,
  color: ColorConstant.textGrey,
);

// 下方 gridView 部分常量
const _gridHorizontalSpacing = 50.0;
const _gridVerticalSpacing = 15.0;
const _gridTextStyle = TextStyle(
  fontSize: 15,
  color: ColorConstant.textLightBlack,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
);

const _commonBorderRadius = 26.0;
const _commonBoxShadow = BoxShadow(
  offset: Offset(0, 6),
  color: ColorConstant.backgroundLighterShadow,
  blurRadius: 10,
);
// 底部留出空间
const _bottomOffset = 50.0;

class HomeInfoWidget extends StatefulWidget {
  @override
  State createState() => _HomeInfoState();
}

Widget _buildBroadcastHead() {
  Widget head = Row(
    children: [
      SvgPicture.asset(SvgIcon.broadcast, color: ColorConstant.iconLightGrey),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(StringConstant.broadcast, style: _broadcastHeadTextStyle),
        ),
        flex: 1,
      ),
      Icon(
        Icons.arrow_forward_ios,
        size: _smallIconSize,
        color: ColorConstant.iconLightGrey,
      ),
    ],
  );
  return wrapPadding(head, _innerVerticalPadding, _innerHorizontalPadding);
}

Widget _buildBroadcastBodyWithData(FullForum forum) {
  final user = forum.lastPostInfo.user;
  final thread = forum.lastPostInfo.thread;
  final subject = thread.subject;
  final date = getDayString(thread.createDate);
  final userName = user.username;
  return Row(
    children: [
      BBSAvatar(
        url: user.avatar,
        radius: _broadcastAvatarRadius,
      ),
      Container(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$subject',
              style: _titleStyle,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            Container(height: _titleSubtitleOffset),
            Text(
              '$date $userName 发布',
              style: _subtitleStyle,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ],
        ),
        flex: 1,
      ),
    ],
  );
}

Widget _buildBroadcastBody() {
  return Consumer<ForumModel>(
    builder: (context, model, child) {
      final forum = model.findByName(StringConstant.broadcast);
      Widget body;
      body = forum == null ? Container() : _buildBroadcastBodyWithData(forum);
      return Container(
        height: 2 * _broadcastAvatarRadius,
        padding: EdgeInsets.only(
          top: _innerVerticalPadding,
          bottom: _innerVerticalPadding * 2,
          left: _innerHorizontalPadding,
          right: _innerHorizontalPadding,
        ),
        child: body,
      );
    },
  );
}

Widget _buildBroadcast() {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: _mainVerticalPadding, horizontal: _mainHorizontalPadding),
    height: _broadcastHeight,
    decoration: BoxDecoration(
      color: ColorConstant.backgroundWhite,
      boxShadow: [_commonBoxShadow],
      borderRadius: BorderRadius.circular(_commonBorderRadius),
    ),
    child: Column(
      children: <Widget>[
        _buildBroadcastHead(),
        Expanded(
          child: _buildBroadcastBody(),
          flex: 1,
        ),
      ],
    ),
  );
}

// contents[0] 是 svg 图片的 url
// contents[1] 是论坛的名字
Widget _buildGridBlock(List<String> contents, BuildContext context) {
  return Consumer<ForumModel>(builder: (context, model, child) {
    return Container(
      decoration: BoxDecoration(boxShadow: [_commonBoxShadow]),
      child: MaterialButton(
        onPressed: () {
          final forum = model.findByName(contents[1]);
          if (forum == null) {
            if (contents[1] == "Report") {
              Navigator.pushNamed(context, BBSRoute.reportPage);
            } else {
              Fluttertoast.showToast(msg: StringConstant.networkError);
            }
          } else {
            Navigator.pushNamed(context, BBSRoute.postList, arguments: forum);
          }
        },
        color: ColorConstant.backgroundWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_commonBorderRadius)),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(contents[0]),
            Container(height: 10), // use for spacing
            Text(
              contents[1],
              style: _gridTextStyle,
            ),
          ],
        ),
      ),
    );
  });
}

Widget _buildGrid(BuildContext context) {
  return Expanded(
    flex: 1,
    child: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
          horizontal: _mainHorizontalPadding * 2,
          vertical: _mainVerticalPadding * 2),
      crossAxisSpacing: _gridHorizontalSpacing,
      mainAxisSpacing: _gridVerticalSpacing,
      children: [
        [SvgIcon.projectTask, StringConstant.uniqueProject],
        [SvgIcon.report, StringConstant.report],
        [SvgIcon.market, StringConstant.uniqueMarket],
        [SvgIcon.freshmanTask, StringConstant.freshmanTask],
        [SvgIcon.file, StringConstant.uniqueData],
        [SvgIcon.share, StringConstant.uniqueShare],
      ].map((e) {
        return GridTile(
          child: _buildGridBlock(e, context),
        );
      }).toList(),
    ),
  );
}

class _HomeInfoState extends State<HomeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBroadcast(),
        _buildGrid(context),
        Container(height: _bottomOffset),
      ],
    );
  }
}
