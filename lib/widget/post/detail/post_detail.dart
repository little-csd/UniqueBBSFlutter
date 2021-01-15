import 'dart:math';

import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/data/bean/forum/post_data.dart';
import 'package:UniqueBBS/data/bean/forum/thread.dart';
import 'package:UniqueBBS/data/bean/forum/thread_info.dart';
import 'package:UniqueBBS/data/bean/user/user_info.dart';
import 'package:UniqueBBS/data/model/post_model.dart';
import 'package:UniqueBBS/tool/helper.dart';
import 'package:UniqueBBS/tool/logger.dart';
import 'package:UniqueBBS/widget/common/common_avatar.dart';
import 'package:UniqueBBS/widget/common/common_popup_input_widget.dart';
import 'package:UniqueBBS/widget/common/custom_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

const _mainHorizontalPadding = 17.0;
// 头部相关
const _maxHeadHeight = 120.0;
const _minHeadHeight = 72.0;
const _headIconTextPadding = 10.0;
const _headAvatarRadius = 26.0;
const _titleFontSize = 20.0;
const _titleTextStyle = TextStyle(
  fontSize: _titleFontSize,
  letterSpacing: 1,
  color: ColorConstant.textBlack,
  fontWeight: FontWeight.bold,
);
const _titleDayTextStyle = TextStyle(
  fontSize: 12,
  letterSpacing: 0.5,
  color: ColorConstant.textLightGrey,
  fontWeight: FontWeight.bold,
);
const _titleNameTextStyle = TextStyle(
  fontSize: 12,
  letterSpacing: 0.5,
  color: ColorConstant.primaryColor,
  fontWeight: FontWeight.bold,
);
const _headDataPadding = EdgeInsets.only(bottom: 20, left: 50);
const _dividerThick = 1.0;
// 内容
const _mainTextStyle = TextStyle(
  fontSize: 14,
  color: ColorConstant.textLightBlack,
  letterSpacing: 1,
);
// 评论部分
const _textOffset = 40.0;
const _commentBoxRadius = 20.0;
const _commentMargin = 10.0;
const _commentInnerPaddingV = 15.0;
const _commentInnerPaddingH = 10.0;
const _commentAvatarRadius = 17.0;
const _commentTextOffset = 10.0;
const _commentEmptyRadius = 20.0;
const _commentEmptyMargin = 10.0;
const _commentEmptyHeight = 35.0;
final _commentNameTextStyle = TextStyle(
  fontSize: 12,
  color: ColorConstant.primaryColor,
);
final _commentTimeTextStyle = TextStyle(
  fontSize: 10,
  color: ColorConstant.textGrey,
);
final _commentMessageTextStyle = TextStyle(
  fontSize: 12,
  color: ColorConstant.textLightBlack,
);
final _noCommentTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: ColorConstant.textGreyForNoComment,
);
final _commentHeadTextStyle = TextStyle(
  fontSize: 12,
  letterSpacing: 1,
  color: ColorConstant.textGrey,
  fontWeight: FontWeight.bold,
);
// 编辑按钮
const _fabPadding = 20.0;
// 底部评论栏
const _bottomHeight = 50.0;
const _bottomIconSize = 24.0;
const _bottomCommentWidth = 130.0;
const _bottomCommentHeight = 32.0;
const _bottomCircularRadius = 30.0;
final _bottomIconTextStyle =
    TextStyle(fontSize: 10.0, color: ColorConstant.textGrey);
final _bottomCommentTextStyle = TextStyle(
  fontSize: 15,
  color: ColorConstant.textGreyForComment,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);

// 根据偏移进度获取透明度，平方看起来会和谐一点
double _getOpacityByProgress(double progress) =>
    (1 - progress) * (1 - progress);

Widget _buildHead(BuildContext context, double height, Thread thread) {
  ThreadInfo threadInfo = thread.thread;
  UserInfo userInfo = thread.user;
  String title = threadInfo?.subject == null ? "" : threadInfo.subject;
  String date = threadInfo?.createDate == null ? "" : threadInfo.createDate;
  String author = userInfo?.username == null ? "" : userInfo.username;
  String avatar = userInfo?.avatar == null ? "" : userInfo.avatar;
  double progress =
      (height - _minHeadHeight) / (_maxHeadHeight - _minHeadHeight);
  final bar = AppBar(
    leading: GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Icon(Icons.arrow_back_ios),
    ),
    bottom: PreferredSize(
      child: Divider(thickness: _dividerThick),
      preferredSize: null,
    ),
    title: Opacity(
      opacity: _getOpacityByProgress(progress),
      child: Text(title, style: TextStyle(color: ColorConstant.textBlack)),
    ),
    flexibleSpace: Opacity(
      opacity: progress,
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: _headDataPadding,
        child: Row(
          children: <Widget>[
            BBSAvatar(avatar, radius: _headAvatarRadius),
            Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _headIconTextPadding),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: title + '\n',
                            style: _titleTextStyle,
                          ),
                          TextSpan(
                            text: getDayString(date),
                            style: _titleDayTextStyle,
                          ),
                          TextSpan(
                            text: '  $author',
                            style: _titleNameTextStyle,
                          )
                        ],
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                    ))),
          ],
        ),
      ),
    ),
  );
  return PreferredSize(child: bar, preferredSize: Size.fromHeight(height));
}

void _tryComment(BuildContext context, PostModel model) {
  if (!model.canPost()) {
    Fluttertoast.showToast(msg: StringConstant.threadClosed);
    return;
  }
  showDialog(
    context: context,
    builder: (context) => CommonPopupInputWidget(
      hint: StringConstant.comment,
      maxLines: 5,
      onSubmitted: (msg) => model.sendPost(msg, StringConstant.noQuote),
    ),
  );
}

Widget _wrapCommentBox(Widget child) {
  return Container(
    decoration: BoxDecoration(
      color: ColorConstant.backgroundWhite,
      borderRadius: BorderRadius.circular(_commentBoxRadius),
      boxShadow: [
        BoxShadow(
          color: ColorConstant.backgroundLightPurple,
          blurRadius: 2,
          spreadRadius: 1,
        )
      ],
    ),
    margin: EdgeInsets.only(top: _commentMargin),
    padding: EdgeInsets.symmetric(
        vertical: _commentInnerPaddingV, horizontal: _commentInnerPaddingH),
    child: child,
  );
}

Widget _buildEmptyComment(BuildContext context, PostModel model) {
  final widget = Row(
    children: [
      BBSAvatar(null, radius: _commentAvatarRadius),
      Expanded(
        child: GestureDetector(
          onTap: () => _tryComment(context, model),
          child: Container(
            height: _commentEmptyHeight,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: _commentEmptyMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_commentEmptyRadius),
              color: ColorConstant.backgroundLightGrey,
            ),
            child: Text(
              '  ${StringConstant.noComment}',
              style: _noCommentTextStyle,
            ),
          ),
        ),
        flex: 1,
      ),
    ],
  );
  return _wrapCommentBox(widget);
}

Widget _buildComment(PostData data) {
  // 暂时找不到数据或者 post 被删除
  if (data == null || !data.post.active) {
    return Container();
  }
  return _wrapCommentBox(Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      BBSAvatar(
        data.user.avatar,
        radius: _commentAvatarRadius,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: _commentTextOffset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                text: data.user.username,
                style: _commentNameTextStyle,
                children: [
                  TextSpan(
                    text: '  ${getDeltaTime(data.post.createDate)}',
                    style: _commentTimeTextStyle,
                  ),
                ],
              )),
              Text(data.post.message, style: _commentMessageTextStyle),
            ],
          ),
        ),
        flex: 1,
      ),
    ],
  ));
}

Widget _buildBody(ScrollController controller, PostModel model) {
  // 评论前面有多少个部件, 为了充分利用 ListView，将帖子内容也塞到里面
  // 没有评论时应该加一个空评论
  return Consumer<PostModel>(
    builder: (context, model, child) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        padding: EdgeInsets.symmetric(horizontal: _mainHorizontalPadding),
        itemBuilder: (context, index) {
          // print('build $index');
          final lastIndex = 2 + max(model.postCount(), 1);
          if (index == 0) {
            // 帖子主体
            String text = model.getFirstPost()?.post?.message;
            return Container(
              margin: EdgeInsets.only(bottom: _textOffset),
              child: Text(text == null ? "" : text, style: _mainTextStyle),
            );
          } else if (index == 1) {
            // 最新评论这一部分，因为不会变化所以放到 child
            return child;
          } else if (index == lastIndex) {
            // 最后一个位置空出一个底部栏高度
            return Container(height: _bottomHeight + _commentMargin);
          }
          // 处理空评论的情况
          if (model.postCount() < 1) {
            return _buildEmptyComment(context, model);
          }
          // 处理实际的评论
          return _buildComment(model.getPostData(index - 2));
        },
        itemCount: 3 + max(model.postCount(), 1),
      );
    },
    child: Text(
      '   ${StringConstant.comments}',
      style: _commentHeadTextStyle,
    ),
  );
}

Widget _buildFAB() {
  return Padding(
    padding: EdgeInsets.only(
        bottom: _bottomHeight + _fabPadding, right: _fabPadding),
    child: CustomFAB([
      StringConstant.edit,
      StringConstant.delete,
    ], [
      () {
        Fluttertoast.showToast(msg: StringConstant.notImpl);
      },
      () {
        Fluttertoast.showToast(msg: StringConstant.notImpl);
      },
    ]),
  );
}

Widget _buildIconWithNumber(String url, int count) {
  return GestureDetector(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          url,
          width: _bottomIconSize,
          height: _bottomIconSize,
        ),
        Text(
          count.toString(),
          style: _bottomIconTextStyle,
        ),
      ],
    ),
    onTap: () => Fluttertoast.showToast(msg: StringConstant.notImpl),
  );
}

Widget _buildBottom(BuildContext context, PostModel model) {
  return Container(
    height: _bottomHeight,
    width: double.infinity,
    color: ColorConstant.backgroundWhite,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => _tryComment(context, model),
          child: Container(
            width: _bottomCommentWidth,
            height: _bottomCommentHeight,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: ColorConstant.backgroundGreyForComment,
              borderRadius: BorderRadius.circular(_bottomCircularRadius),
            ),
            child: Text(
              '  ${StringConstant.comment}',
              style: _bottomCommentTextStyle,
            ),
          ),
        ),
        _buildIconWithNumber(SvgIcon.like, 0),
        _buildIconWithNumber(SvgIcon.comment, 0),
        _buildIconWithNumber(SvgIcon.star, 0),
      ],
    ),
  );
}

class PostDetailWidget extends StatefulWidget {
  final Thread thread;

  PostDetailWidget(this.thread) : assert(thread != null);

  @override
  State createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetailWidget> {
  static const _TAG = "PostDetailWidget";
  ScrollController _controller;
  double _headHeight = _maxHeadHeight;
  PostModel model;

  void _initParas() {
    double offset = 0;
    if (_controller.hasClients && _controller.offset > 0) {
      offset = _controller.offset;
    }
    _headHeight = _maxHeadHeight - offset < _minHeadHeight
        ? _minHeadHeight
        : _maxHeadHeight - offset;
    Logger.v(_TAG, 'head height = $_headHeight');
  }

  @override
  Widget build(BuildContext context) {
    _initParas();
    return ChangeNotifierProvider(
      create: (_) => model,
      child: Scaffold(
        appBar: _buildHead(context, _headHeight, widget.thread),
        // 这里使用 stack 是为了预防后面界面要改底部透明啥的
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            _buildBody(_controller, model),
            _buildFAB(),
            _buildBottom(context, model),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      Logger.v(_TAG, 'offset ${_controller.offset}');

      /// 优化: 超过范围后就不要再触发重新 build 了
      if ((_controller.offset > (_maxHeadHeight - _minHeadHeight) &&
              _headHeight == _minHeadHeight) ||
          (_controller.offset < 0 && _headHeight == _maxHeadHeight)) {
        return;
      }
      setState(() {});
    });
    model = PostModel(widget.thread.thread);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
