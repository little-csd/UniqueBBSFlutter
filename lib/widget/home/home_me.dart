import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/bean/user/user.dart';
import 'package:UniqueBBS/data/dio.dart';
import 'package:UniqueBBS/data/model/user_model.dart';
import 'package:UniqueBBS/data/repo.dart';
import 'package:UniqueBBS/widget/common/common_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

/// '我的'界面从上到下依次是:
/// notification 图标
/// 头像
/// 名字
/// 活跃积分
/// 组别
/// 签名
/// 手机号
/// 微信
/// 邮箱
/// 查看帖子
/// 修改密码
/// 退出登录

// 底部留出空间
const _bottomOffset = 50.0;
// 整体
const _mainHorizontalPadding = 15.0;
// 通知
const _notificationHeight = 90.0;
// 头像部分
const _portraitRadius = 35.5;
// 名字部分
const _nameTextStyle = TextStyle(
  fontSize: 17,
  color: ColorConstant.textLightBlack,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);
// 活跃积分
const _activePointTextStyle = TextStyle(
  fontSize: 12,
  color: ColorConstant.textGrey,
  fontWeight: FontWeight.bold,
);
const _activePointNumStyle = TextStyle(
  fontSize: 12,
  color: ColorConstant.primaryColor,
  fontWeight: FontWeight.bold,
);
// 标识卡片部分
const _cardRadius = 25.0;
const _cardTextVerticalPadding = 4.0;
const _cardTextHorizontalPadding = 10.0;
const _cardTextStyle = TextStyle(fontSize: 10, color: ColorConstant.textWhite);
// 中间信息部分
const _iconSize = 20.0;
const _iconTextOffset = 10.0;
const _personalVerticalPadding = 14.0;
const _maxSignLine = 10;
final _divider = Container(
  height: 0.2,
  margin: EdgeInsets.symmetric(vertical: 8.0),
  color: ColorConstant.backgroundGrey,
);
const _signatureTextStyle = TextStyle(
  color: ColorConstant.textBlack,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
const _personalTextStyle = TextStyle(
  color: ColorConstant.textBlack,
  fontSize: 13,
  fontWeight: FontWeight.bold,
);
const _personalDataTextStyle = TextStyle(
  color: ColorConstant.textGrey,
  fontSize: 12,
);

// 底部几个按钮部分
const _buttonTextPadding = 10.0;
const _buttonTextHorizontalPadding = 20.0;
const _buttonRadius = 25.0;
const _buttonTextFontSize = 15.0;
const _buttonTextSpacing = 2.0;
final _buttonRoundedBorder =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(_buttonRadius));

Widget _buildNotification() {
  return Container(
    height: _notificationHeight,
    alignment: Alignment.bottomRight,
    child: IconButton(
      icon: SvgPicture.asset(SvgIcon.notification),
      onPressed: () {
        Fluttertoast.showToast(msg: StringConstant.notImpl);
      },
    ),
  );
}

Widget _buildHeadPortrait(User user) {
  return BBSAvatar(
    user?.user?.avatar,
    radius: _portraitRadius,
  );
}

Widget _buildName(User me) {
  final name = me == null ? StringConstant.noData : me.user.username;
  return Container(
    alignment: Alignment.center,
    child: Text(
      name,
      style: _nameTextStyle,
    ),
  );
}

Widget _buildActivePoint() {
  return Container(
    alignment: Alignment.center,
    child: Text.rich(TextSpan(
      children: [
        TextSpan(
            text: StringConstant.activePoint, style: _activePointTextStyle),
        TextSpan(text: ': 0', style: _activePointNumStyle),
      ],
    )),
  );
}

/// 此处如果一个人同时位于很多个组，有可能会溢出
Widget _buildCards(User me) {
  if (me == null) {
    return Container();
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: me.groups.map((e) {
      return Container(
        decoration: BoxDecoration(
          color: ColorConstant.primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_cardRadius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: _cardTextVerticalPadding,
            horizontal: _cardTextHorizontalPadding,
          ),
          child: Text(
            e.name,
            style: _cardTextStyle,
          ),
        ),
      );
    }).toList(),
  );
}

Widget _wrapBoxShadow(Widget child, double verticalPadding) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
        vertical: verticalPadding, horizontal: _buttonTextHorizontalPadding),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(_buttonRadius),
      border: Border.all(color: ColorConstant.borderLightPink),
      color: ColorConstant.backgroundWhite,
    ),
    child: child,
  );
}

Widget _buildSignature(User me, bool isOpen, VoidCallback callback) {
  final signature = me == null ? StringConstant.noData : me.user.signature;
  final widget = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${StringConstant.signature}   ',
        style: _signatureTextStyle,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(top: 2),
          child: Text(
            signature,
            style: _personalDataTextStyle,
            maxLines: isOpen ? _maxSignLine : 1,
          ),
        ),
        flex: 1,
      ),
      Container(
        child: GestureDetector(
          onTap: callback,
          child: isOpen
              ? Icon(Icons.keyboard_arrow_up)
              : Icon(Icons.keyboard_arrow_down),
        ),
      ),
    ],
  );
  return _wrapBoxShadow(widget, _buttonTextPadding);
}

Widget _wrapPersonalDataLine(String iconSrc, String type, String data) {
  // 每一行第一个数据是 Icon 名字, 第二个是提示信息, 第三个是实际数据
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: _iconSize,
          height: _iconSize,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: _iconTextOffset),
          child: SvgPicture.asset(iconSrc),
        ),
        Text(
          type,
          style: _personalTextStyle,
        ),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.end,
            style: _personalDataTextStyle,
          ),
          flex: 1,
        ),
      ],
    ),
  );
}

Widget _buildPersonalData(User me) {
  // 这里将构建一行 UI 所需要的字符串都封装在一起, 后面直接传递给 _wrapPersonalDataLine
  final mobile = me == null ? StringConstant.noData : me.user.mobile;
  final weChat = me == null ? StringConstant.noData : me.user.wechat;
  final email = me == null ? StringConstant.noData : me.user.email;
  return _wrapBoxShadow(
    Column(
      children: [
        _wrapPersonalDataLine(
            SvgIcon.phoneNumber, StringConstant.phoneNumber, mobile),
        _divider,
        _wrapPersonalDataLine(SvgIcon.weChat, StringConstant.weChat, weChat),
        _divider,
        _wrapPersonalDataLine(SvgIcon.mailbox, StringConstant.mailbox, email),
      ],
    ),
    _personalVerticalPadding,
  );
}

Widget _buildShowMyPost(BuildContext context, User user) {
  return FlatButton(
    minWidth: double.infinity,
    onPressed: () {
      if (user != null) {
        Navigator.of(context).pushNamed(BBSRoute.postList, arguments: null);
      }
    },
    shape: _buttonRoundedBorder,
    color: ColorConstant.primaryColor,
    padding: const EdgeInsets.symmetric(vertical: _buttonTextPadding),
    child: Text(
      StringConstant.showMyPost,
      style: const TextStyle(
        fontSize: _buttonTextFontSize,
        color: ColorConstant.textWhite,
        letterSpacing: _buttonTextSpacing,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildChangeInfo(BuildContext context) {
  return Container(
    width: double.infinity,
    child: OutlineButton(
      color: ColorConstant.backgroundBlack,
      onPressed: () {
        Fluttertoast.showToast(msg: StringConstant.notImpl);
      },
      shape: _buttonRoundedBorder,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _buttonTextPadding),
        child: Text(
          StringConstant.changeInfo,
          style: const TextStyle(
            fontSize: _buttonTextFontSize,
            color: ColorConstant.textBlack,
            letterSpacing: _buttonTextSpacing,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _buildLogout(BuildContext context) {
  return MaterialButton(
    padding: EdgeInsets.symmetric(vertical: _buttonTextPadding),
    onPressed: () {
      Navigator.of(context).popAndPushNamed(BBSRoute.login);
      Server.instance.logout();
    },
    minWidth: double.infinity,
    shape: _buttonRoundedBorder,
    child: Text(
      StringConstant.logout,
      style: const TextStyle(
        fontSize: _buttonTextFontSize,
        color: ColorConstant.textRed,
        letterSpacing: _buttonTextSpacing,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class HomeMeWidget extends StatefulWidget {
  @override
  State createState() => _HomeMeState();
}

class _HomeMeState extends State<HomeMeWidget> {
  bool _isSignOpen = false; // 是否展开签名

  @override
  Widget build(BuildContext context) {
    final signOpenCallback = () => setState(() {
          _isSignOpen = !_isSignOpen;
        });
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        User me = userModel.find(Repo.instance.uid);
        Repo.instance.me = me;
        return Column(
          children: [
            _buildNotification(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: _mainHorizontalPadding),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeadPortrait(me),
                    Container(height: 8),
                    _buildName(me),
                    _buildActivePoint(),
                    Container(height: 10),
                    _buildCards(me),
                    Container(height: 23),
                    _buildSignature(me, _isSignOpen, signOpenCallback),
                    Container(height: 11),
                    _buildPersonalData(me),
                    Container(height: 30),
                    _buildShowMyPost(context, me),
                    Container(height: 10),
                    _buildChangeInfo(context),
                    Container(height: 10),
                    _buildLogout(context),
                    Container(height: _bottomOffset),
                  ],
                ),
              ),
              flex: 1,
            ),
          ],
        );
      },
    );
  }
}
