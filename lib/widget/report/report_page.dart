import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/report/report_item.dart';
import 'package:flutter/material.dart';

class ReportPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPageState();
}

class ReportPageState extends State<StatefulWidget> {
  // todo: test data, refactor before push
  var _words = <String>['loading'];

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
      body: _buildAllList(),
    );
  }

  _buildAllList() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildYearList();
      },
    );
  }

  _buildYearList() {
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
                  "2020",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: ReportItem());
            },
          ),
        ],
      ),
    );
  }
}
