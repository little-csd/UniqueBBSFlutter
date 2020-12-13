import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/home_body.dart';
import 'package:UniqueBBSFlutter/widget/home_me.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  State createState() => _HomeState();
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
        onTap: (index) {
          if (index == _index) return;
          _index = index;
          setState(() {});
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: StringConstant.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: StringConstant.me,
          ),
        ],
      ),
    );
  }
}
