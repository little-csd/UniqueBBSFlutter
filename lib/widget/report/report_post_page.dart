import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _weeklyTag = "weekly report";
const _dailyTag = "daily report";

class ReportPostPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPostPageState();
}

class ReportPostPageState extends State<ReportPostPageWidget> {
  bool isWeekly;
  String content;

  _createReport() {
    // todo : test data, refactor after finished
    content = "test data";
    Server.instance.createReport(isWeekly, content).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundLightGrey,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _createReport();
            },
            child: Text(
              StringConstant.post,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorConstant.textPostPurple,
                fontSize: 18,
              ),
            ),
          ),
        ],
        title: Text(
          StringConstant.postReportTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: [
        _buildChooseTypeBar(),
        _buildInputArea(),
      ],
    );
  }

  _buildChooseTypeBar() {
    return Container(
      color: ColorConstant.backgroundLightGrey,
      alignment: Alignment.center,
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 29),
          Text(
            "板块",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstant.textGrey,
            ),
          ),
          Container(width: 6),
          Container(
              height: 25,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: ColorConstant.borderGray)),
              child: FlatButton(
                onPressed: () {
                  return DropdownButton(
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          _dailyTag,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        child: Text(
                          _weeklyTag,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  );
                },
                splashColor: Colors.white,
                highlightColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _weeklyTag,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(width: 17),
                    SvgPicture.asset(SvgIcon.moduleChooseTag),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  _buildInputArea() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: StringConstant.pleaseInput,
          hintStyle: TextStyle(
            color: ColorConstant.textGrey,
          ),
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
