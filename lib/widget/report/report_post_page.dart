import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/widget/common/network_error_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _weeklyTag = "weekly report";
const _dailyTag = "daily report";

class ReportPostPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReportPostPageState();
}

class ReportPostPageState extends State<ReportPostPageWidget> {
  bool _isWeekly = true;
  String _content;
  TextEditingController _textEditingController;

  _createReport() {
    _content = _textEditingController.text;
    print(_isWeekly);
    Server.instance.createReport(true, _content).then((value) {
      if (value.success) {
        Fluttertoast.showToast(msg: StringConstant.postReportSuccess);
        Navigator.pop(context);
      } else {
          buildErrorBottomSheet(context, value.msg);
      }
    });
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
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
                  _isWeekly = !_isWeekly;
                  setState(() {
                  });
                },
                splashColor: Colors.white,
                highlightColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isWeekly ? _weeklyTag : _dailyTag,
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
        controller: _textEditingController,
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
