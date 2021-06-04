import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unique_bbs/config/constant.dart';

const _inputFieldBorderRadius = 16.0;
const _inputFieldTextOffsetH = 10.0;
const _inputFieldTextOffsetV = 8.0;
const _heightForOneLine = 21.0;
const _fontSize = 15.0;

const _textIconPadding = 12.0;
const _submitBtnRadius = 32.0;

Widget _buildInputField(
  BuildContext context,
  String hint,
  int maxLines,
  ValueChanged<String> onChanged,
  ValueChanged<String>? onSubmitted,
) {
  final maxHeight = _heightForOneLine * maxLines + _inputFieldTextOffsetV * 2;
  return Container(
    constraints: BoxConstraints(maxHeight: maxHeight),
    child: TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.bold,
          color: ColorConstant.textGreyForComment,
        ),
        isDense: true,
        filled: true,
        fillColor: ColorConstant.inputPurple,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputFieldBorderRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: _inputFieldTextOffsetV,
          horizontal: _inputFieldTextOffsetH,
        ),
      ),
      autofocus: true,
      cursorWidth: 1.0,
      cursorColor: ColorConstant.primaryColor,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
        color: ColorConstant.textPurpleForReply,
      ),
      maxLines: null,
      scrollPhysics: BouncingScrollPhysics(),
      onChanged: onChanged,
      onSubmitted: (str) {
        Navigator.of(context).pop();
        onSubmitted?.call(str);
      },
    ),
  );
}

Widget _buildSubmitBtn(BuildContext context, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      width: _submitBtnRadius,
      height: _submitBtnRadius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConstant.primaryColor,
      ),
      child: Icon(
        Icons.arrow_upward,
        color: ColorConstant.backgroundWhite,
      ),
    ),
  );
}

/// 弹出一个输入框。参考调用方式:
/// showDialog(
///   context: context,
///   builder: (context) => CommonPopupInputWidget(),
/// );
/// @param hint 提示信息
/// @param maxLines 最大行数
/// @param onSubmitted 提交确认后的回调
///
class CommonPopupInputWidget extends StatefulWidget {
  CommonPopupInputWidget({
    this.hint = '',
    this.maxLines = 5,
    this.onSubmitted,
  });

  final String hint;
  final int maxLines;
  final ValueChanged<String>? onSubmitted;

  @override
  State createState() => CommonPopupInputWidgetState();
}

class CommonPopupInputWidgetState extends State<CommonPopupInputWidget> {
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(onTap: () => Navigator.of(context).pop()),
          ),
          Container(
            color: ColorConstant.backgroundWhite,
            padding: EdgeInsets.all(_textIconPadding),
            child: Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    context,
                    widget.hint,
                    widget.maxLines,
                    (str) => msg = str,
                    widget.onSubmitted,
                  ),
                ),
                Container(width: _textIconPadding),
                _buildSubmitBtn(context, () {
                  widget.onSubmitted?.call(msg);
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
