import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/data/bean/report/report.dart';
import 'package:unique_bbs/data/dio.dart';
import 'package:unique_bbs/widget/common/network_error_bottom_sheet.dart';

const _weeklyTag = "weekly report";
const _dailyTag = "daily report";

class ReportPostPageWidget extends StatefulWidget {
  final Report? report;

  ReportPostPageWidget(this.report);

  @override
  State<StatefulWidget> createState() => ReportPostPageState();
}

class ReportPostPageState extends State<ReportPostPageWidget> {
  bool _isWeekly = true;
  bool _isUpdating = false;
  late TextEditingController _textEditingController = _createTextController();

  _createReport() {
    String content = _textEditingController.text;
    if (content.isEmpty) {
      Fluttertoast.showToast(msg: StringConstant.noPostEmpty);
      return;
    }
    if (_isUpdating) {
      Report report = widget.report as Report;
      Server.instance.updateReport(report.rid, content).then((rsp) {
        if (rsp.success) {
          Fluttertoast.showToast(msg: StringConstant.updateReportSuccess);
          Navigator.pop(context);
        } else {
          buildErrorBottomSheet(context, rsp.msg!);
        }
      });
    } else {
      Server.instance.createReport(_isWeekly, content).then((rsp) {
        if (rsp.success) {
          Fluttertoast.showToast(msg: StringConstant.postReportSuccess);
          Navigator.pop(context);
        } else {
          buildErrorBottomSheet(context, rsp.msg!);
        }
      });
    }
  }

  TextEditingController _createTextController() {
    final report = widget.report;
    if (report != null) {
      _isWeekly = report.isWeek;
      _isUpdating = true;
      return TextEditingController.fromValue(
        TextEditingValue(
          text: report.message,
          selection: TextSelection.fromPosition(TextPosition(
              affinity: TextAffinity.downstream,
              offset: report.message.length)),
        ),
      );
    } else {
      return TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) => AppBar(
        backgroundColor: ColorConstant.backgroundLightGrey,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
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
                fontSize: 16,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
        title: Text(
          StringConstant.postReportTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );

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
              fontSize: 15,
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
                  if (_isUpdating) {
                    return;
                  }
                  _isWeekly = !_isWeekly;
                  setState(() {});
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
