import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/widget/home_body.dart';
import 'package:UniqueBBSFlutter/widget/home_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _bottomHeight = 50.0;
const _bottomMaskHeight = 120.0;
const _bottomButtonOffset = 15.0;
const _bottomButtonHeight = 50.0;
const _bottomAddIconSize = 25.0;

class HomeWidget extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

typedef _TapCallback = void Function(int);

void _clickHomeSelect(BuildContext context) async {
  var data = await Navigator.pushNamed(context, BBSRoute.selectPlate);
  print(data);
}

Widget _getBottomItem(
    String src, int index, int selectedIndex, _TapCallback callback) {
  return FlatButton(
    onPressed: () => callback(index),
    splashColor: ColorConstant.invisibleBlack,
    highlightColor: ColorConstant.invisibleBlack,
    child: SvgPicture.asset(
      src,
      color: index == selectedIndex
          ? ColorConstant.primaryColor
          : ColorConstant.textGrey,
    ),
  );
}

Widget _getBottomButton(BuildContext context) {
  return Container(
    height: _bottomButtonHeight,
    padding: EdgeInsets.only(bottom: _bottomButtonOffset),
    child: Hero(
      tag: StringConstant.selectPlateHero,
      child: MaterialButton(
        onPressed: () => _clickHomeSelect(context),
        shape: CircleBorder(),
        color: ColorConstant.backgroundWhite,
        elevation: 1,
        child: Icon(
          Icons.add,
          size: _bottomAddIconSize,
          color: ColorConstant.backgroundGrey,
        ),
      ),
    ),
  );
}

Widget _wrapMask(Widget widget) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        height: _bottomMaskHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 1.0],
            colors: [
              ColorConstant.lightBackgroundPurple,
              ColorConstant.invisibleBlack,
            ],
          ),
        ),
      ),
      widget,
    ],
  );
}

class _HomeState extends State<HomeWidget> {
  int _index = 0;
  List<Widget> _pages = [
    HomeBodyWidget(),
    HomeMeWidget(),
  ];

  // 这里设置成异步是为了防止 UI 重绘的过程中触发回调
  void _tokenErr(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
        context, BBSRoute.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // 初始化 server 的 token error callback, 以便 token 出现问题的时候可以回退到登录页
    Server.instance.tokenErrCallback = () => _tokenErr(context);
    final tapIconCallback = (int index) {
      if (index == _index) return;
      setState(() {
        _index = index;
      });
    };
    return Scaffold(
      body: _wrapMask(Column(
        children: [
          Expanded(
            child: _pages[_index],
            flex: 1,
          ),
          Container(
            height: _bottomButtonHeight,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: _bottomHeight,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    SvgIcon.homeBottomBg,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _getBottomItem(SvgIcon.message, 0, _index, tapIconCallback),
                    _getBottomButton(context),
                    _getBottomItem(SvgIcon.person, 1, _index, tapIconCallback),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
