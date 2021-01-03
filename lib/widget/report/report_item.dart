import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/widget/common/filled_background_text.dart';
import 'package:flutter/material.dart';

var _tagWeekly = "WEEKLY";
var _tagDaily = "DAILY";

class ReportItem extends Container {
  String year;
  String mouth;
  String day;
  String reportContent;
  bool isWeekly;

  ReportItem(
      {this.year, this.mouth, this.day, this.reportContent, this.isWeekly});

  @override
  Widget get child {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20, right: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstant.lightBorderPink,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.lightBorderPink,
            blurRadius: 10.0,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildFilledBackgroundText(isWeekly ? _tagWeekly : _tagDaily, 50),
              Container(
                width: 10,
              ),
            ],
          ),
          Container(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
              ),
              Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(mouth),
                ],
              ),
              Container(
                width: 27,
              ),
              Expanded(
                child: Text(reportContent),
              ),
            ],
          )
        ],
      ),
    );
  }
}
