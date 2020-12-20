import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user.dart';
import 'package:UniqueBBSFlutter/data/model/avatar_model.dart';
import 'package:UniqueBBSFlutter/data/model/user_model.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
/// 生日
/// 查看帖子
/// 修改密码
/// 退出登录

// 整体
const _mainHorizontalPadding = 15.0;
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
    height: 90,
    alignment: Alignment.bottomRight,
    child: IconButton(
      icon: SvgPicture.asset(SvgIcon.notification),
      onPressed: () => print('hello mike'),
    ),
  );
}

final notFound = Container(
  alignment: Alignment.center,
  child: CircleAvatar(
    radius: _portraitRadius,
    backgroundImage:
        NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/'
            'it/u=1336318030,2258820972&fm=26&gp=0.jpg'),
  ),
);

Widget _buildHeadPortrait(User user) {
  return Consumer<AvatarModel>(
    builder: (context, model, child) {
      if (user == null) {
        return notFound;
      }
      final image = model.find(user.user.avatar);
      if (image == null) {
        return notFound;
      }
      return Container(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: _portraitRadius,
          backgroundImage: image.image,
        ),
      );
    },
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
        TextSpan(text: ': 100', style: _activePointNumStyle),
      ],
    )),
  );
}

// final cardData = [
//   'DESIGN',
//   'BBS',
// ];
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

/// 此处注意 signature 过长的情况，可能发生 ui 问题
Widget _buildSignature(User me) {
  final signature = me == null ? StringConstant.noData : me.user.signature;
  final text = Text.rich(TextSpan(children: [
    TextSpan(
      text: StringConstant.signature,
      style: const TextStyle(
          color: ColorConstant.textBlack, fontSize: _buttonTextFontSize),
    ),
    TextSpan(
      text: '   $signature',
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

String _replaceWithStar(String data, int show) {
  if (show >= 0 || data.length <= 4) return data;
  return data.replaceRange(2, data.length - 2, '*****');
}

Widget _getWidgetByShow(int show, int index, ShowStateCallback callback) {
  if (show > 0) {
    return GestureDetector(
      onTap: () => callback(index, -1),
      child: Icon(
        Icons.remove_red_eye_outlined,
        size: _iconSize,
      ),
    );
  } else if (show < 0) {
    return GestureDetector(
      onTap: () => callback(index, 1),
      child: Icon(
        Icons.panorama_fish_eye,
        size: _iconSize,
      ),
    );
  } else {
    return Container(
      height: _iconSize,
      width: _iconSize,
    );
  }
}

Widget _wrapPersonalDataLine(
    List<String> itemData, int isShow, int index, ShowStateCallback callback) {
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
          child: SvgPicture.asset(itemData[0]),
        ),
        Text(itemData[1]),
        Expanded(
          child: Text(
            _replaceWithStar(itemData[2], isShow),
            textAlign: TextAlign.end,
            style: const TextStyle(color: ColorConstant.textGrey),
          ),
          flex: 1,
        ),
        _getWidgetByShow(isShow, index, callback),
      ],
    ),
  );
}

/// TODO: 此处后台没有生日信息, 先放个学号
Widget _buildPersonalData(
    User me, ShowStateCallback callback, List<int> showState) {
  // 这里将构建一行 UI 所需要的字符串都封装在一起, 后面直接传递给 _wrapPersonalDataLine
  final mobile = me == null ? StringConstant.noData : me.user.mobile;
  final weChat = me == null ? StringConstant.noData : me.user.wechat;
  final email = me == null ? StringConstant.noData : me.user.email;
  final studentID = me == null ? StringConstant.noData : me.user.studentID;
  final itemData = [
    [SvgIcon.phoneNumber, StringConstant.phoneNumber, mobile],
    [SvgIcon.weChat, StringConstant.weChat, weChat],
    [SvgIcon.mailbox, StringConstant.mailbox, email],
    [SvgIcon.birthday, StringConstant.birthday, studentID],
  ];
  return _wrapBoxShadow(
    Column(
      children: [
        _wrapPersonalDataLine(itemData[0], showState[0], 0, callback),
        divider,
        _wrapPersonalDataLine(itemData[1], showState[1], 1, callback),
        divider,
        _wrapPersonalDataLine(itemData[2], showState[2], 2, callback),
        divider,
        _wrapPersonalDataLine(itemData[3], showState[3], 3, callback),
      ],
    ),
    _personalVerticalPadding,
  );
}

Widget _buildShowMyPost(BuildContext context) {
  return FlatButton(
    minWidth: double.infinity,
    onPressed: () {
      print('查看帖子');
      // Logger.i('HomeMe', 'hello');
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

Widget _buildLogout(BuildContext context) {
  return MaterialButton(
    padding: EdgeInsets.symmetric(vertical: _buttonTextPadding),
    onPressed: () => print('退出登录'),
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

typedef ShowStateCallback = void Function(int, int);

/// 进入 me 界面前要保证自己的 user 信息必须存在
class _HomeMeState extends State<HomeMeWidget> {
  // 是否展示: 1 表示全部展示, -1 表示部分隐藏, 0 表示不显示图标
  var _showState = [1, 1, 0, 0];

  @override
  Widget build(BuildContext context) {
    final _showStateCallback = (int index, int state) {
      setState(() {
        _showState[index] = state;
      });
    };
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        User me = userModel.find(Repo.instance.uid);
        return Column(
          children: [
            _buildNotification(),
            SingleChildScrollView(
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
                  _buildSignature(me),
                  Container(height: 20),
                  _buildPersonalData(me, _showStateCallback, _showState),
                  Container(height: 30),
                  _buildShowMyPost(context),
                  Container(height: 10),
                  _buildChangPwd(context),
                  Container(height: 10),
                  _buildLogout(context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
