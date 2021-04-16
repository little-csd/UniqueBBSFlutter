import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/bean/report/report.dart';
import 'package:UniqueBBS/tool/helper.dart';
import 'package:UniqueBBS/widget/common/filled_background_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';

var _tagWeekly = "WEEKLY";
var _tagDaily = "DAILY";
const _yearStartPosition = 0;
const _yearEndPosition = 4;
const _dayStartPosition = 8;
const _dayEndPosition = 10;
const _monthStartPosition = 5;
const _monthEndPosition = 7;
const _monthText = '月';

const _contentTextStyle = TextStyle(
  fontSize: 14,
  letterSpacing: 0.5,
);
const _dayTextStyle = TextStyle(
  fontSize: 27,
  fontWeight: FontWeight.bold,
);
const _monthTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: ColorConstant.textLightGrey,
);

class ReportItem extends StatelessWidget {
  final Report data;
  final String _year;
  final String _month;
  final String _day;
  final String _reportContent;
  final bool _isWeekly;

  ReportItem(this.data)
      : _year = data.createDate.substring(_yearStartPosition, _yearEndPosition),
        _day = data.createDate.substring(_dayStartPosition, _dayEndPosition),
        _month =
            data.createDate.substring(_monthStartPosition, _monthEndPosition),
        _reportContent = data.message,
        _isWeekly = data.isWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20, right: 5),
      decoration: _itemDecoration(),
      child: _buildItem(context),
    );
  }

  _buildItem(BuildContext context) {
    var nowDateTime = DateTime.now();
    if (nowDateTime.year == int.parse(_year) &&
        nowDateTime.month == int.parse(_month) &&
        nowDateTime.day == int.parse(_day)) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(BBSRoute.postReport, arguments: data);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildItemTypeTag(),
            _buildItemBody(),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildItemTypeTag(),
          _buildItemBody(),
        ],
      );
    }
  }

  _itemDecoration() => BoxDecoration(
        border: Border.all(
          color: ColorConstant.borderLightPink,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.borderLightPink,
            blurRadius: 10.0,
          ),
        ],
        color: Colors.white,
      );

  _buildItemTypeTag() => Container(
        padding: EdgeInsets.only(right: 10, bottom: 10),
        alignment: Alignment.centerRight,
        child:
            buildFilledBackgroundText(_isWeekly ? _tagWeekly : _tagDaily, 50),
      );

  _buildItemBody() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 22, right: 27),
            child: Column(
              children: [
                Text(_day, style: _dayTextStyle),
                Text(_month + _monthText, style: _monthTextStyle),
              ],
            ),
          ),
          Expanded(
            child: Markdown(
              data: _reportContent ?? '',
              imageBuilder: (uri, title, alt) {
                if (uri.scheme == StringConstant.networkProtocol) {
                  return Image.network(uri.toString());
                } else {
                  Fluttertoast.showToast(
                      msg: 'Not support scheme: ${uri.scheme}');
                }
                return Text(uri.toString());
              },
              onTapLink: (text, href, title) => launchBrowser(href),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      );
}
