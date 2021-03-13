import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/model/report_model.dart';
import 'package:UniqueBBS/widget/report/report_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const _yearListPaddingL = 20.0;
const _yearListPaddingT = 17.0;
const _yearListPaddingB = 7.0;
const _yearListIconSize = 17.0;
const _yearListIconTextGap = 4.0;
const _itemListVerticalPadding = 20.0;
const _itemListHorizonPadding = 5.0;

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
        appBar: _buildAppBar(context),
        body: _buildYearList(),
      ),
    );
  }

  _buildAppBar(BuildContext context) => AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: ColorConstant.backgroundLightGrey,
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset(SvgIcon.postReport),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(BBSRoute.postReport, arguments: null);
              }),
        ],
        title: Text(
          StringConstant.reportTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      );

  _buildYearList() {
    return Consumer<ReportModel>(builder: (context, model, child) {
      if (model.isNoReport()) {
        return _buildEmptyListText();
      } else {
        return ListView.builder(
          itemCount: model.keysCount(),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          itemBuilder: (context, index) {
            var year = model.getYear(index);
            return _buildItemList(year, model);
          },
        );
      }
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
            child: ReportItem(item));
      },
    );
  }

  _buildItemListTitle(int year) {
    return Padding(
      padding: EdgeInsets.only(
        left: _yearListPaddingL,
        top: _yearListPaddingT,
        bottom: _yearListPaddingB,
      ),
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
            style: TextStyle(
              color: ColorConstant.textBlack,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  _buildEmptyListText() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text(
        StringConstant.noReportPost,
        style: TextStyle(
            fontSize: 13,
            color: ColorConstant.textLightPurPle,
            letterSpacing: 3),
      ),
    );
  }
}
