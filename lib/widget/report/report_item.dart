import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:flutter/material.dart';

var _tagWeekly = "WEEKLY";
var _tagDaily = "DAILY";

class ReportItem extends Container {
  String year ;
  String mouth;
  String day;
  String reportContent;
  bool isWeekly;

  ReportItem({
    this.year,
    this.mouth,
    this.day,
    this.reportContent,
    this.isWeekly
  });

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
              _buildColorBackgroundText(isWeekly ? _tagWeekly : _tagDaily),
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

_buildColorBackgroundText(String text) {
  return Container(
    alignment: Alignment.center,
    width: 50,
    height: 12,
    decoration: BoxDecoration(
      color: ColorConstant.textBackgroundLightPurple,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
