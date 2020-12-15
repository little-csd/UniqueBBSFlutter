import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/home_body.dart';
import 'package:UniqueBBSFlutter/widget/home_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeWidget extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

BottomNavigationBarItem _getBottomBarItem(
    String src, int index, int selectedIndex) {
  var color;
  if (index == selectedIndex) {
    color = ColorConstant.primaryColor;
  } else {
    color = ColorConstant.textGray;
  }
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      src,
      color: color,
    ),
    label: '',
  );
}

class _HomeState extends State<HomeWidget> {
  int _index = 0;
  List<Widget> _pages = [
    HomeBodyWidget(),
    HomeMeWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => print('hello'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == _index) return;
          _index = index;
          setState(() {});
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        items: [
          _getBottomBarItem(SvgIcon.message, 0, _index),
          _getBottomBarItem(SvgIcon.person, 1, _index),
        ],
      ),
    );
  }
}
