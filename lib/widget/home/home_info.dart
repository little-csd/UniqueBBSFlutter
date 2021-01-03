import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/bean/forum/full_forum.dart';
import 'package:UniqueBBS/data/model/forum_model.dart';
import 'package:UniqueBBS/tool/helper.dart';
import 'package:UniqueBBS/widget/common/common_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

const _mainHorizontalPadding = 20.0;
const _mainVerticalPadding = 10.0;

// 通知公告部分常量
const _broadcastHeight = 150.0;
const _innerHorizontalPadding = 15.0;
const _innerVerticalPadding = 10.0;
const _smallIconSize = 18.0;
const _broadcastRadius = 25.0;
const _titleStyle = TextStyle(
  fontSize: 18,
  color: ColorConstant.textBlack,
);
const _subtitleStyle = TextStyle(fontSize: 12, color: ColorConstant.textGrey);

// 下方 gridView 部分常量
const _gridHorizontalSpacing = 50.0;
const _gridVerticalSpacing = 15.0;
const _gridBorderRadius = 26.0;
final _gridTextStyle = TextStyle(fontSize: 18, color: ColorConstant.textBlack);
// 底部留出空间
const _bottomOffset = 50.0;

class HomeInfoWidget extends StatefulWidget {
  @override
  State createState() => _HomeInfoState();
}

Widget _buildBroadcastHead() {
  Widget head = Row(
    children: [
      SvgPicture.asset(SvgIcon.broadcast),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(StringConstant.broadcast),
        ),
        flex: 1,
      ),
      Icon(
        Icons.arrow_forward_ios,
        size: _smallIconSize,
        color: Colors.grey,
      ),
    ],
  );
  return wrapPadding(head, _innerVerticalPadding, _innerHorizontalPadding);
}

Widget _buildBroadcastBodyWithData(FullForum forum) {
  final user = forum.lastPostInfo.user;
  final thread = forum.lastPostInfo.thread;
  final subject = thread?.subject == null ? "" : thread.subject;
  final date = getDayString(thread?.createDate);
  final userName = user?.username == null ? "" : user.username;
  return Row(
    children: [
      BBSAvatar(
        user?.avatar,
        radius: _broadcastRadius,
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
        height: 2 * _broadcastRadius,
        padding: EdgeInsets.symmetric(
            vertical: _innerVerticalPadding,
            horizontal: _innerHorizontalPadding),
        child: body,
      );
    },
  );
}

Widget _buildBroadcast() {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: _mainVerticalPadding, horizontal: _mainHorizontalPadding),
    height: _broadcastHeight,
    child: Card(
      color: ColorConstant.backgroundWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: <Widget>[
          _buildBroadcastHead(),
          Expanded(
            child: _buildBroadcastBody(),
            flex: 1,
          ),
        ],
      ),
    ),
  );
}

// contents[0] 是 svg 图片的 url
// contents[1] 是论坛的名字
Widget _buildGridBlock(List<String> contents, BuildContext context) {
  return Consumer<ForumModel>(builder: (context, model, child) {
    return MaterialButton(
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
          borderRadius: BorderRadius.circular(_gridBorderRadius)),
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
