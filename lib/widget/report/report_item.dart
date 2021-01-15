import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/widget/common/filled_background_text.dart';
import 'package:flutter/material.dart';

var _tagWeekly = "WEEKLY";
var _tagDaily = "DAILY";

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

class ReportItem extends Container {
  final String year;
  final String month;
  final String day;
  final String reportContent;
  final bool isWeekly;

  ReportItem(
      {this.year, this.month, this.day, this.reportContent, this.isWeekly});

  @override
  Widget get child {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20, right: 5),
      decoration: BoxDecoration(
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
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10, bottom: 10),
            alignment: Alignment.centerRight,
            child: buildFilledBackgroundText(
                isWeekly ? _tagWeekly : _tagDaily, 50),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 22, right: 27),
                child: Column(
                  children: [
                    Text(day, style: _dayTextStyle),
                    Text(month, style: _monthTextStyle),
                  ],
                ),
              ),
              Expanded(child: Text(reportContent, style: _contentTextStyle)),
            ],
          )
        ],
      ),
    );
  }
}
