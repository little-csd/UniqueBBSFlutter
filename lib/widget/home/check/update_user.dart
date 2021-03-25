import 'dart:developer';

import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/bean/user/user.dart';
import 'package:UniqueBBS/data/dio.dart';
import 'package:UniqueBBS/data/model/user_model.dart';
import 'package:UniqueBBS/data/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

/// 更新用户信息界面
const _textFieldEdge = 16.0;
const _textFieldCirAngle = 17.0;
const _saveFontSize = 15.0;

const _regEmail =
    r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$';
// 手机号验证暂时不支持国外号码
const _regPhone = r'^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$';
const _saveString = "保存";
const _errorPost = '提交失败，是不是网络开小差了?';
const _infoWrong = '输入格式有问题，检查检查？';
const _successPost = '提交成功！';

class UserUpdateWidget extends StatefulWidget {
  @override
  _UserUpdateWidgetState createState() => _UserUpdateWidgetState();
}

class _UserUpdateWidgetState extends State<UserUpdateWidget> {
  final _signTextController = TextEditingController();
  final _userMobileController = TextEditingController();
  final _weChatTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildUpdateList(context),
    );
  }

  _buildAppBar(BuildContext context) => AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: ColorConstant.backgroundLightGrey,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: _textFieldEdge),
            child: Consumer<UserModel>(builder: (context, userModel, child) {
              User me = userModel.find(Repo.instance.uid);
              return TextButton(
                child: Text(
                  _saveString,
                  style: TextStyle(
                    fontSize: _saveFontSize,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.textPurpleForUpdate,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  bool isEmailValid = _isInfoValid(_emailTextController.text,_userMobileController.text);
                  if (isEmailValid) {
                    me.user.mobile = _userMobileController.text;
                    me.user.email = _emailTextController.text;
                    me.user.wechat = _weChatTextController.text;
                    me.user.signature = _signTextController.text;

                    /// TODO : 更新重置界面
                    Server.instance.updateUser(me.user).then((rsp) {
                      if (rsp.success) {
                        Fluttertoast.showToast(msg: _successPost);
                        userModel.put(Repo.instance.uid, me);
                        Navigator.pop(context);
                      } else {

                        /// to delete
                        Fluttertoast.showToast(msg: rsp.msg);
                      }
                    });
                  } else{
                    Fluttertoast.showToast(msg: _infoWrong);
                  }
                },
              );
            }),
          ),
        ],
        title: Text(
          StringConstant.changeInfo,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      );

  _buildUpdateList(BuildContext context) => Consumer<UserModel>(
        builder: (context, userModel, child) {
          User me = userModel.find(Repo.instance.uid);

          return Column(
            children: [
              _buildTextField(
                  controller: _signTextController,
                  length: 100,
                  str: me.user.signature),
              Container(
                height: 11,
              ),
              _buildTextField(
                  controller: _userMobileController,
                  length: 20,
                  str: me.user.mobile,
                  inputType: TextInputType.phone),
              Container(
                height: 11,
              ),
              _buildTextField(
                  controller: _weChatTextController,
                  length: 20,
                  str: me.user.wechat),
              Container(
                height: 11,
              ),
              _buildTextField(
                  controller: _emailTextController,
                  length: 20,
                  str: me.user.email),
            ],
          );
        },
      );

  Widget _buildTextField({controller, length, str,inputType}) {
    return UpdateTextInputField(
        controller: controller, length: length, str: str,inputType: inputType,);
  }

  /// 判断输入的邮箱是否合法
  bool _isInfoValid(email,phone) {
    RegExp regEmail = RegExp(_regEmail);
    RegExp regPhone = RegExp(_regPhone);
    if (regEmail.hasMatch(email)&&regPhone.hasMatch(phone)){
      return true;
    }
    return false;
  }
}

//输入框Widget
class UpdateTextInputField extends StatefulWidget {
  final controller;
  final length;
  final str;
  final inputType;
  UpdateTextInputField({this.controller, this.length, this.str,this.inputType = TextInputType.text});

  @override
  _UpdateTextInputFieldState createState() =>
      _UpdateTextInputFieldState(controller, length, str,inputType);
}

class _UpdateTextInputFieldState extends State<UpdateTextInputField> {
  final TextEditingController _controller;
  final length;
  final str;
  final inputType;
  _UpdateTextInputFieldState(this._controller, this.length, this.str,this.inputType);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化Textfield默認值
    _controller.text = str;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _textFieldEdge, right: _textFieldEdge),
      child: TextField(
        controller: _controller,
        maxLines: 3,
        minLines: 1,
        keyboardType: inputType,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.clear_outlined),
              iconSize: 23.0,
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              },
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_textFieldCirAngle))),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(length),
        ],
      ),
    );
  }
}
