import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';

class _FilledTextField extends TextField {
  const _FilledTextField(
      {this.radius, this.hint, this.filledColor, this.hintColor});

  final Radius radius;
  final String hint;
  final Color filledColor;
  final Color hintColor;

  @override
  TextStyle get style => TextStyle(
        fontSize: 14,
        letterSpacing: 2,
      );

  @override
  InputDecoration get decoration => InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.inputPurple),
            borderRadius: BorderRadius.all(radius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.inputPurple),
            borderRadius: BorderRadius.all(radius)),
        filled: true,
        fillColor: filledColor,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(10),
      );
}

_FilledTextField buildFilledTextField(
    String hint, Radius radius, Color filledColor, Color hintColor) {
  return _FilledTextField(
    hint: hint,
    radius: radius,
    filledColor: filledColor,
    hintColor: hintColor,
  );
}
