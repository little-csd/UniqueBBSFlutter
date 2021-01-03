import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/model/report_model.dart';
import 'package:UniqueBBS/widget/report/report_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const _yearListPadding = 20.0;
const _yearListIconSize = 17.0;
const _yearListIconTextGap = 4.0;
const _itemListVerticalPadding = 20.0;
const _itemListHorizonPadding = 5.0;
const _dayHighPosition = 8;
const _dayLowPosition = 9;
const _monthHighPosition = 5;
const _monthLowPosition = 6;
const _monthText = '月';

class ReportPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPageState();
}

class ReportPageState extends State<StatefulWidget> {
  var model = ReportModel();
  ScrollController scrollController = ScrollController();
  bool haveData = false;

  void fetchData() {
    model.fetchData();
  }

  @override
  void initState() {
    _initScrollController();
    super.initState();
    fetchData();
  }

  void _initScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstant.backgroundLightGrey,
            actions: <Widget>[
              IconButton(
                  icon: SvgPicture.asset(SvgIcon.postReport),
                  onPressed: () {
                    Navigator.pushNamed(context, BBSRoute.postReport);
                  }),
            ],
            title: Text(
              StringConstant.reportTitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _buildYearList()),
    );
  }

  _buildYearList() {
    return Consumer<ReportModel>(builder: (context, model, child) {
      return ListView.builder(
        itemCount: model.keysCount(),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        itemBuilder: (context, index) {
          var year = model.keysFirst() - index;
          return _buildItemList(year, model);
        },
      );
    });
  }

  _buildItemList(int year, ReportModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemListTitle(year),
          _buildItemListBody(year, model),
        ],
      ),
    );
  }

  _buildItemListBody(int year, ReportModel model) {
    return ListView.builder(
      itemCount: model.singleYearListLength(year),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var item = model.getItemData(year, index);
        return Padding(
            padding: EdgeInsets.fromLTRB(
              _itemListVerticalPadding,
              _itemListHorizonPadding,
              _itemListVerticalPadding,
              _itemListHorizonPadding,
            ),
            child: ReportItem(
              day: item.createDate[_dayHighPosition] +
                  item.createDate[_dayLowPosition],
              mouth: item.createDate[_monthHighPosition] +
                  item.createDate[_monthLowPosition] +
                  _monthText,
              reportContent: item.message,
              isWeekly: item.isWeek,
            ));
      },
    );
  }

  Padding _buildItemListTitle(int year) {
    return Padding(
      padding: EdgeInsets.only(left: _yearListPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor,
              shape: BoxShape.circle,
            ),
            height: _yearListIconSize,
            width: _yearListIconSize,
          ),
          Container(
            width: _yearListIconTextGap,
          ),
          Text(
            year.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
