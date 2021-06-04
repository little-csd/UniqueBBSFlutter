import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/data/bean/report/report.dart';
import 'package:unique_bbs/data/bean/report/reports.dart';
import 'package:unique_bbs/data/dio.dart';
import 'package:unique_bbs/data/repo.dart';

class ReportModel extends ChangeNotifier {
  Map<int, List> _yearList = Map<int, List>();
  bool _fetching = false;
  bool _fetchComplete = false;
  int _fetchedPage = 0;
  List<int> _sortedYears = [];

  isNoReport() => _sortedYears.length == 0;

  getYear(int index) => _sortedYears[index];

  keysCount() => _yearList.keys.length;

  singleYearListLength(int year) => _yearList[year]!.length;

  getItemData(int year, int index) => _yearList[year]![index];

  fetchData() {
    if (_fetching || _fetchComplete) {
      return;
    }
    _fetching = true;
    Server.instance.reports(Repo.instance.uid, _fetchedPage + 1).then((rsp) {
      if (!rsp.success) {
        Fluttertoast.showToast(msg: rsp.msg!);
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => fetchData());
        return;
      }
      Reports data = rsp.data!;
      int tot = data.reports.length;
      for (int i = 0; i < tot; i++) {
        final report = data.reports[i];
        int year = _generateYearNum(report);
        List? reportsInYear = _yearList[year];
        if (reportsInYear == null) {
          reportsInYear = [];
          reportsInYear.add(report);
          _yearList[year] = reportsInYear;
        } else {
          reportsInYear.add(report);
        }
      }
      _onFetchFinished();
    });
  }

  _onFetchFinished() {
    _fetchedPage++;
    _fetching = false;
    _generateAndSortYears();
    notifyListeners();
  }

  _generateYearNum(Report data) => int.parse(data.createDate.substring(0, 4));

  _generateAndSortYears() {
    _sortedYears = _yearList.keys.toList();
    _sortedYears.sort((left, right) => right.compareTo(left));
  }
}
