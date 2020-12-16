import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/home_forum.dart';
import 'package:UniqueBBSFlutter/widget/home_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBodyWidget extends StatefulWidget {
  @override
  State createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBodyWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
          height: 90,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: TabBar(
                  labelStyle: TextStyle(fontSize: 16),
                  labelColor: ColorConstant.primaryColor,
                  unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 5),
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(text: StringConstant.info),
                    Tab(text: StringConstant.forum)
                  ],
                ),
                width: 140,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(SvgIcon.search),
                      onPressed: () => print('search'),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(SvgIcon.notification),
                      onPressed: () => print('notification'),
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
            physics: ClampingScrollPhysics(),
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
