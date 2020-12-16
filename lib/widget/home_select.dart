import 'dart:math';

import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO: 这里大小最好是根据屏幕长宽去计算，可能会 overflow
const _cancelIconSize = 60.0;
const _selectBtnSize = 80.0;
const _selectBtnRadius = 130.0;
final emptyContainer = Container(height: 10);
final _btnTextStyle = TextStyle(
  fontSize: 20,
  color: ColorConstant.textBlack,
);
final _selectTextStyle = TextStyle(
  fontSize: 20,
  color: ColorConstant.textGrey,
  decoration: TextDecoration.none,
);
const data = [
  '项目\n任务',
  '闲杂\n讨论',
  '联创\n趣梗',
  '知识\n分享',
  '新人\n任务',
  'report',
  '通知\n公告',
  '文件\n留存',
  '奇思\n妙想',
];

Widget _wrapData(BuildContext context, String data) {
  return MaterialButton(
    onPressed: () => Navigator.of(context).pop(data),
    color: ColorConstant.backgroundWhite,
    shape: const CircleBorder(),
    height: _selectBtnSize,
    child: Text(data, style: _btnTextStyle),
  );
}

Widget _wrapTransform(Widget child, double angle, double radius) {
  double dx = sin(angle) * radius;
  double dy = cos(angle) * radius;
  return Container(
    transform: Matrix4.translationValues(dx, -dy, 0),
    alignment: Alignment.center,
    child: child,
  );
}

Widget _buildCircularWidget(BuildContext context) {
  var widgets = data.map((e) => _wrapData(context, e)).toList();
  double deltaAngle = 2 * pi / (data.length - 1);
  widgets[0] = _wrapTransform(widgets[0], 0, 0);
  for (int i = 1; i < data.length; i++) {
    widgets[i] =
        _wrapTransform(widgets[i], deltaAngle * (i - 1), _selectBtnRadius);
  }
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: size.width,
    alignment: Alignment.center,
    child: Stack(
      children: widgets,
    ),
  );
}

class HomeSelectWidget extends StatefulWidget {
  @override
  State createState() => _HomeSelectState();
}

class _HomeSelectState extends State<HomeSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.backgroundLightGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            StringConstant.selectBlockHint,
            style: _selectTextStyle,
          ),
          emptyContainer,
          SvgPicture.asset(SvgIcon.selectPlateIcon),
          emptyContainer,
          _buildCircularWidget(context),
          emptyContainer,
          FlatButton(
            onPressed: () => Navigator.pop(context, ''),
            child: SvgPicture.asset(
              SvgIcon.selectPlateCancel,
              width: _cancelIconSize,
              height: _cancelIconSize,
            ),
          ),
          emptyContainer,
        ],
      ),
    );
  }
}
