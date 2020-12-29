import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/report/report.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:UniqueBBSFlutter/widget/report/report_item.dart';
import 'package:flutter/material.dart';

int _fetching = 0;
int _idle = 1;

class ReportPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPageState();
}

class ReportPageState extends State<StatefulWidget> {
  var reportList = List();
  var yearList = Map<int, List>();
  int page = 1;
  bool haveData = false;
  int fetchState = _idle;

  void fetchData() {
    if (fetchState == _fetching) {
      return;
    } else {
      fetchState = _fetching;
    }

    Server.instance.reports(Repo.instance.uid, page).then((rsp) {
      for (int i = 0; i < rsp.data.reports.length; i++) {
        var data = rsp.data.reports[i];
        var year = int.parse(data.createDate[0] +
            data.createDate[1] +
            data.createDate[2] +
            data.createDate[3]);
        if (yearList.keys.contains(year)) {
          print("$year exists");
          yearList[year].insert(yearList[year].length, data);
        } else {
          print("$year new");
          yearList[year] = List();
          yearList[year].insert(yearList[year].length, data);
        }
      }
      haveData = true;
      print(yearList.length);
      page++;
      setState(() {});
      fetchState = _idle;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundLightGrey,
        title: Text(
          StringConstant.reportTitle,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: haveData ? _buildYearList() : null
    );
  }

  _buildYearList() {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });

    return ListView.builder(
      itemCount: yearList.keys.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      controller: scrollController,
      itemBuilder: (context, index) {
        var year = yearList.keys.first - index;
        return _buildItemList(year);
      },
    );
  }

  _buildItemList(int year) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            // todo: test data, refactor before push
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  height: 17,
                  width: 17,
                ),
                Container(
                  width: 4,
                ),
                Text(
                  year.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: yearList[year].length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: ReportItem(
                    day: yearList[year][index].createDate[8] +
                        yearList[year][index].createDate[9],
                    mouth: yearList[year][index].createDate[5] +
                        yearList[year][index].createDate[6] +
                        "月",
                    reportContent: yearList[year][index].message,
                    isWeekly: yearList[year][index].isWeek,
                  ));
            },
          ),
        ],
      ),
    );
  }
}
