import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/widget/home/home_forum.dart';
import 'package:UniqueBBS/widget/home/home_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/route.dart';

const _tabHeight = 90.0;
const _tabBarWidth = 140.0;
const _indicatorPadding = 5.0;
const _labelTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const _unLabelTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

class HomeBodyWidget extends StatefulWidget {
  @override
  State createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBodyWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: _tabHeight,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: TabBar(
                  labelStyle: _labelTextStyle,
                  labelColor: ColorConstant.primaryColor,
                  unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
                  unselectedLabelStyle: _unLabelTextStyle,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: _indicatorPadding),
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(text: StringConstant.info),
                    Tab(text: StringConstant.forum)
                  ],
                ),
                width: _tabBarWidth,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(SvgIcon.search),
                      onPressed: () {
                        Navigator.pushNamed(context, BBSRoute.search);
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(SvgIcon.notification),
                      onPressed: () {
                        Fluttertoast.showToast(msg: StringConstant.notImpl);
                      },
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              HomeInfoWidget(),
              HomeForumWidget(),
            ],
          ),
        )
      ],
    );
  }
}
