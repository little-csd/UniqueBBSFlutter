import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/data/bean/user/user.dart';
import 'package:unique_bbs/data/dio.dart';
import 'package:unique_bbs/data/model/user_model.dart';
import 'package:unique_bbs/data/repo.dart';

// 更新用户信息界面
const _textFieldEdge = 16.0;
const _textFieldCirAngle = 17.0;
const _saveFontSize = 15.0;
// 用户更新信息最长字数
const _maxSignaLength = 99;
const _maxPhoneLength = 11;
const _maxWechatLength = 20;
const _maxEmailLength = 40;
const _regEmail =
    r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$';
// 手机号验证暂时不支持国外号码
const _regPhone = r'^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$';

// 字体样式
const _inputTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: ColorConstant.textGreyForUpdate,
);
const _barTitleTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: ColorConstant.textGreyForUpdate,
);

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
                  StringConstant.saveString,
                  style: TextStyle(
                    fontSize: _saveFontSize,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.textPurpleForUpdate,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => _checkAndLogin(me, userModel),
              );
            }),
          ),
        ],
        title: Text(
          StringConstant.changeInfo,
          style: _barTitleTextStyle,
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
                length: _maxSignaLength,
                str: me.user.signature,
              ),
              Container(height: 11),
              _buildTextField(
                controller: _userMobileController,
                length: _maxPhoneLength,
                str: me.user.mobile,
                inputType: TextInputType.phone,
              ),
              Container(height: 11),
              _buildTextField(
                controller: _weChatTextController,
                length: _maxWechatLength,
                str: me.user.wechat,
              ),
              Container(height: 11),
              _buildTextField(
                controller: _emailTextController,
                length: _maxEmailLength,
                str: me.user.email,
              ),
            ],
          );
        },
      );

  Widget _buildTextField({controller, length, str, inputType}) {
    return UpdateTextInputField(
      controller: controller,
      length: length,
      str: str,
      inputType: inputType,
    );
  }

  // 判断输入的邮箱是否合法
  bool _isInfoValid(email, phone) {
    RegExp regEmail = RegExp(_regEmail);
    RegExp regPhone = RegExp(_regPhone);
    if (regEmail.hasMatch(email) && regPhone.hasMatch(phone)) {
      return true;
    }
    return false;
  }

  _checkAndLogin(me, userModel) {
    if (_isInfoValid(_emailTextController.text, _userMobileController.text)) {
      // TODO 应当弃用这种方式保存
      var _tempMobile = me.user.mobile;
      var _tempWechat = me.user.wechat;
      var _tempEmail = me.user.email;
      var _tempSigna = me.user.signature;
      me.user.mobile = _userMobileController.text;
      me.user.email = _emailTextController.text;
      me.user.wechat = _weChatTextController.text;
      me.user.signature = _signTextController.text;
      // 发起网络请求
      _updateUser(
          me, userModel, _tempMobile, _tempEmail, _tempSigna, _tempWechat);
    } else {
      // 格式检验失败
      Fluttertoast.showToast(msg: StringConstant.infoWrong);
    }
  }

  // 格式检验成功发起网络请求
  _updateUser(me, userModel, _tempMobile, _tempEmail, _tempSigna, _tempWechat) {
    Server.instance.updateUser(me.user).then((rsp) {
      if (rsp.success) {
        Fluttertoast.showToast(msg: StringConstant.successPost);
        //更新返回后的userModel
        userModel.put(Repo.instance.uid, me);
        Navigator.pop(context);
      } else {
        /// 对网络失败后的操作进行还原处理
        /// 避免更改model中的数据
        Fluttertoast.showToast(msg: StringConstant.errorPost);
        me.user.mobile = _tempMobile;
        me.user.email = _tempEmail;
        me.user.signature = _tempSigna;
        me.user.wechat = _tempWechat;
      }
    });
  }
}

//输入框Widget
class UpdateTextInputField extends StatefulWidget {
  final controller;
  final length;
  final str;
  final inputType;

  UpdateTextInputField(
      {this.controller,
      this.length,
      this.str,
      this.inputType = TextInputType.text});

  @override
  _UpdateTextInputFieldState createState() =>
      _UpdateTextInputFieldState(controller, length, str, inputType);
}

class _UpdateTextInputFieldState extends State<UpdateTextInputField> {
  final TextEditingController _controller;
  final length;
  final str;
  final inputType;

  _UpdateTextInputFieldState(
      this._controller, this.length, this.str, this.inputType);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化 Textfield 默认值
    _controller.text = str;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _textFieldEdge, right: _textFieldEdge),
      child: TextField(
        controller: _controller,
        maxLines: 4,
        minLines: 1,
        keyboardType: inputType,
        style: _inputTextStyle,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
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
