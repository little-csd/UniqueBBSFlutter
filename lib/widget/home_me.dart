import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
/// 生日
/// 查看帖子
/// 修改密码
/// 退出登录

// 整体
const _mainHorizontalPadding = 15.0;
// 通知部分
const _notificationTopPadding = 40.0;
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
const _iconSize = 20.0;
const _iconTextOffset = 5.0;
const _personalVerticalPadding = 14.0;
final divider = Container(
  height: 0.2,
  margin: EdgeInsets.symmetric(vertical: 8.0),
  color: ColorConstant.backgroundGrey,
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
    padding: EdgeInsets.only(top: _notificationTopPadding),
    alignment: Alignment.centerRight,
    child: IconButton(
      icon: SvgPicture.asset(SvgIcon.notification),
      onPressed: () => print('hello mike'),
    ),
  );
}

Widget _buildHeadPortrait() {
  return Container(
    alignment: Alignment.center,
    child: CircleAvatar(
      radius: _portraitRadius,
      backgroundImage:
          NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/'
              'it/u=1336318030,2258820972&fm=26&gp=0.jpg'),
    ),
  );
}

Widget _buildName() {
  return Container(
    alignment: Alignment.center,
    child: Text(
      'CheN',
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
        TextSpan(text: ': 100', style: _activePointNumStyle),
      ],
    )),
  );
}

final cardData = [
  'DESIGN',
  'BBS',
];

Widget _buildCards() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: cardData.map((e) {
      return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_cardRadius)),
        color: ColorConstant.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _cardTextVerticalPadding,
              horizontal: _cardTextHorizontalPadding),
          child: Text(
            e,
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
          blurRadius: 1.0,
        ),
      ],
      color: ColorConstant.backgroundLightGrey,
    ),
    child: child,
  );
}

Widget _buildSignature() {
  final text = Text.rich(TextSpan(children: [
    TextSpan(
      text: StringConstant.signature,
      style: const TextStyle(
          color: ColorConstant.textBlack, fontSize: _buttonTextFontSize),
    ),
    TextSpan(
      text: '   Hi~',
      style: const TextStyle(
          color: ColorConstant.textGrey, fontSize: _buttonTextFontSize),
    ),
  ]));
  return _wrapBoxShadow(text, _buttonTextPadding);
}

final personalData = [
  '12344448901',
  '123456798',
  '474594049@qq.com',
  '2000.05.10'
];

Widget _getWidgetByShow(int show) {
  if (show > 0) {
    return Icon(
      Icons.remove_red_eye_outlined,
      size: _iconSize,
    );
  } else if (show < 0) {
    return Icon(
      Icons.panorama_fish_eye,
      size: _iconSize,
    );
  } else {
    return Container(
      height: _iconSize,
      width: _iconSize,
    );
  }
}

Widget _wrapPersonalDataLine(
    String iconSrc, String itemType, String data, int show) {
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
        Text(itemType),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.end,
            style: const TextStyle(color: ColorConstant.textGrey),
          ),
          flex: 1,
        ),
        _getWidgetByShow(show),
      ],
    ),
  );
}

Widget _buildPersonalData() {
  return _wrapBoxShadow(
    Column(
      children: [
        _wrapPersonalDataLine(SvgIcon.phoneNumber, StringConstant.phoneNumber,
            personalData[0], 1),
        divider,
        _wrapPersonalDataLine(
            SvgIcon.wechat, StringConstant.wechat, personalData[1], -1),
        divider,
        _wrapPersonalDataLine(
            SvgIcon.mailbox, StringConstant.mailbox, personalData[2], 0),
        divider,
        _wrapPersonalDataLine(
            SvgIcon.birthday, StringConstant.birthday, personalData[3], 0),
      ],
    ),
    _personalVerticalPadding,
  );
}

Widget _buildShowMyPost() {
  return FlatButton(
    minWidth: double.infinity,
    onPressed: () => print('查看帖子'),
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

Widget _buildChangPwd() {
  return Container(
    width: double.infinity,
    child: OutlineButton(
      color: ColorConstant.backgroundBlack,
      onPressed: () => print('修改密码'),
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

Widget _buildLogout() {
  return MaterialButton(
    padding: EdgeInsets.symmetric(vertical: _buttonTextPadding),
    onPressed: () => print('退出登录'),
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
  @override
  Widget build(BuildContext context) {
    final children = [
      _buildNotification(),
      _buildHeadPortrait(),
      _buildName(),
      _buildActivePoint(),
      _buildCards(),
      _buildSignature(),
      _buildPersonalData(),
      _buildShowMyPost(),
      _buildChangPwd(),
      _buildLogout(),
    ];
    final offset = [0.0, 7.0, 5.0, 5.0, 15.0, 15.0, 20.0, 10.0, 10.0, 10.0];
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: _mainHorizontalPadding),
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => Container(height: offset[index]),
      itemCount: children.length,
    );
  }
}
