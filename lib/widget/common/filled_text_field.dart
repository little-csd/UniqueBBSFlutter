import 'package:flutter/material.dart';
import 'package:unique_bbs/config/constant.dart';

class FilledTextField extends TextField {
  const FilledTextField(
      {this.radius,
      this.hint,
      this.filledColor,
      this.hintColor,
      this.onChanged,
      this.obscureText});

  final Radius radius;
  final String hint;
  final Color filledColor;
  final Color hintColor;
  final ValueChanged<String> onChanged;
  final bool obscureText;

  @override
  TextStyle get style => TextStyle(
        fontSize: 14,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      );

  @override
  InputDecoration get decoration => InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.inputPurple),
          borderRadius: BorderRadius.all(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.inputPurple),
          borderRadius: BorderRadius.all(radius),
        ),
        filled: true,
        fillColor: filledColor,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 22),
      );
}
