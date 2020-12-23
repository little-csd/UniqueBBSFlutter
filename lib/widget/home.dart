import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/widget/home_body.dart';
import 'package:UniqueBBSFlutter/widget/home_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _bottomHeight = 65.0;
const _bottomButtonOffset = 10.0;

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
    splashColor: ColorConstant.invisibleColor,
    highlightColor: ColorConstant.invisibleColor,
    child: SvgPicture.asset(
      src,
      color: index == selectedIndex
          ? ColorConstant.primaryColor
          : ColorConstant.textGrey,
    ),
  );
}

Widget _getBottomButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: _bottomButtonOffset),
    child: MaterialButton(
      onPressed: () => _clickHomeSelect(context),
      shape: CircleBorder(),
      color: ColorConstant.backgroundBlack,
      child: Icon(
        Icons.add,
        color: ColorConstant.backgroundGrey,
      ),
    ),
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
      body: Column(
        children: [
          Expanded(
            child: _pages[_index],
            flex: 1,
          ),
          Container(
            height: _bottomHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  'images/home_bottom_bg.jpg',
                ).image,
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getBottomItem(SvgIcon.message, 0, _index, tapIconCallback),
                _getBottomButton(context),
                _getBottomItem(SvgIcon.person, 1, _index, tapIconCallback),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
