import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';

class ReportItem extends Container {
  // todo : test data, please refactor after bind to a model
  String year = "2020";
  String mouth = "09月";
  String day = "22";
  String reportContent = "今天早上吃啥 \n中午吃啥 \n晚上吃啥 \n夜宵吃七幺幺";

  @override
  Widget get child {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20),
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
              _buildColorBackgroundText("   DAILY  "),
              Container(width: 10,),
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
