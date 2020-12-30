import 'package:UniqueBBSFlutter/data/bean/report/report.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:flutter/material.dart';

class ReportModel extends ChangeNotifier {
  Map<int, List> yearList = Map<int, List>();
  int pageNum = 1;
  bool ready = false;
  bool isFetching = false;

  keysCount() => yearList.keys.length;
  keysFirst() => yearList.keys.first;
  singleYearListLength(int year) => yearList[year].length;
  getItemData(int year, int index) => yearList[year][index];

  fetchData() {
    if (isFetching) {
      return;
    }
    isFetching = true;
    Server.instance.reports(Repo.instance.uid, pageNum).then((rsp) {
      for (int i = 0; i < rsp.data.reports.length; i++) {
        var data = rsp.data.reports[i];
        int year = _generateYearNum(data);
        if (yearList.keys.contains(year)) {
          yearList[year].insert(yearList[year].length, data);
        } else {
          yearList[year] = List();
          yearList[year].insert(yearList[year].length, data);
        }
      }
      _onFetchFinished();
    });
  }

  _onFetchFinished() {
    ready = true;
    pageNum++;
    isFetching = false;
    notifyListeners();
  }

  int _generateYearNum(Report data) {
    var year = int.parse(data.createDate[0] +
        data.createDate[1] +
        data.createDate[2] +
        data.createDate[3]);
    return year;
  }
}
