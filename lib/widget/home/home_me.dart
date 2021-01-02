import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user.dart';
import 'package:UniqueBBSFlutter/data/model/user_model.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:UniqueBBSFlutter/widget/common/common_avatar.dart';
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

// 整体
const _mainHorizontalPadding = 15.0;
// 通知
const _notificationHeight = 90.0;
// 头像部分
const _portraitRadius = 40.0;
// 名字部分
final _nameTextStyle = TextStyle(fontSize: 18, color: ColorConstant.textBlack);
// 活跃积分
final _activePointTextStyle =
    TextStyle(fontSize: 14, color: ColorConstant.textGrey);
final _activePointNumStyle =
    TextStyle(fontSize: 14, color: ColorConstant.primaryColor);
// 标识卡片部分
const _cardRadius = 30.0;
const _cardTextVerticalPadding = 5.0;
const _cardTextHorizontalPadding = 10.0;
final _cardTextStyle = TextStyle(fontSize: 14, color: ColorConstant.textWhite);
// 中间信息部分
const _shadowBlueRadius = 1.0;
const _iconSize = 20.0;
const _iconTextOffset = 10.0;
const _personalVerticalPadding = 14.0;
const _maxSignLine = 10;
final divider = Container(
  height: 0.2,
  margin: EdgeInsets.symmetric(vertical: 8.0),
  color: ColorConstant.backgroundGrey,
);
final _personalTextStyle = TextStyle(
  color: ColorConstant.textBlack,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
final _personalDataTextStyle = TextStyle(
  color: ColorConstant.textGrey,
  fontSize: 13,
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
      return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_cardRadius)),
        color: ColorConstant.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _cardTextVerticalPadding,
              horizontal: _cardTextHorizontalPadding),
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
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: _shadowBlueRadius,
        ),
      ],
      color: ColorConstant.backgroundLightGrey,
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
        style: _personalTextStyle,
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
        divider,
        _wrapPersonalDataLine(SvgIcon.weChat, StringConstant.weChat, weChat),
        divider,
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
      print('查看帖子');
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
      ),
    ),
  );
}

Widget _buildChangPwd(BuildContext context) {
  return Container(
    width: double.infinity,
    child: OutlineButton(
      color: ColorConstant.backgroundBlack,
      onPressed: () => Navigator.of(context).pushNamed(BBSRoute.pwSet),
      shape: _buttonRoundedBorder,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _buttonTextPadding),
        child: Text(
          StringConstant.changePassword,
          style: const TextStyle(
            fontSize: _buttonTextFontSize,
            color: ColorConstant.textBlack,
            letterSpacing: _buttonTextSpacing,
          ),
        ),
      ),
    ),
  );
}

Widget _buildLogout(BuildContext context) {
  return MaterialButton(
    padding: EdgeInsets.symmetric(vertical: _buttonTextPadding),
    onPressed: () => Navigator.of(context).popAndPushNamed(BBSRoute.login),
    minWidth: double.infinity,
    shape: _buttonRoundedBorder,
    child: Text(
      StringConstant.logout,
      style: const TextStyle(
        fontSize: _buttonTextFontSize,
        color: ColorConstant.textRed,
        letterSpacing: _buttonTextSpacing,
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
                child: Column(
                  children: [
                    _buildHeadPortrait(me),
                    Container(height: 7),
                    _buildName(me),
                    Container(height: 5),
                    _buildActivePoint(),
                    Container(height: 5),
                    _buildCards(me),
                    Container(height: 15),
                    _buildSignature(me, _isSignOpen, signOpenCallback),
                    Container(height: 20),
                    _buildPersonalData(me),
                    Container(height: 30),
                    _buildShowMyPost(context, me),
                    Container(height: 10),
                    _buildChangPwd(context),
                    Container(height: 10),
                    _buildLogout(context),
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
