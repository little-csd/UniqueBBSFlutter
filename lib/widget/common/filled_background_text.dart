import 'package:UniqueBBS/config/constant.dart';
import 'package:flutter/material.dart';

buildFilledBackgroundText(String text, double width) {
  return Container(
    alignment: Alignment.center,
    width: width,
    height: 12,
    decoration: BoxDecoration(
      color: ColorConstant.textBackgroundLightPurple,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 9,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
