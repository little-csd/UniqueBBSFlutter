import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/dio.dart';
import 'package:UniqueBBS/widget/home/home_body.dart';
import 'package:UniqueBBS/widget/home/home_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _bottomHeight = 50.0;
const _bottomMaskHeight = 120.0;
const _bottomButtonOffset = 15.0;
const _bottomButtonHeight = 40.0;
final _bottomButtonShadow = BoxShadow(
  color: ColorConstant.lightBackgroundShadow,
  spreadRadius: 1,
  blurRadius: 1.5,
  offset: Offset(0, 3),
);

class HomeWidget extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

typedef _TapCallback = void Function(int);

Widget _buildBottomItem(
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

Widget _buildBottomButton(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: _bottomButtonOffset),
    decoration: BoxDecoration(
      boxShadow: [_bottomButtonShadow],
      shape: BoxShape.circle,
    ),
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, BBSRoute.selectPlate),
      child: Hero(
        tag: StringConstant.selectPlateHero,
        child: SvgPicture.asset(
          SvgIcon.homeBottomBtn,
          height: _bottomButtonHeight,
          width: _bottomButtonHeight,
        ),
      ),
    ),
  );
}

Widget _buildMask() {
  return Container(
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: _pages[_index],
          ),
          _buildMask(),
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
              _buildBottomItem(SvgIcon.message, 0, _index, tapIconCallback),
              _buildBottomButton(context),
              _buildBottomItem(SvgIcon.person, 1, _index, tapIconCallback),
            ],
          ),
        ],
      ),
    );
  }
}
