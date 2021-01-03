import 'package:UniqueBBS/config/constant.dart';
import 'package:flutter/material.dart';

import 'normal_bottom_sheet.dart';

buildErrorBottomSheet(BuildContext context, String content) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildErrorBottomSheetBody(context, content);
      });
}

buildNetworkErrorBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildErrorBottomSheetBody(context, StringConstant.networkError);
      });
}

_buildErrorBottomSheetBody(BuildContext context, String content) {
  return NormalBottomSheetContainer(
      bottomCardRadius: 30,
      totalHeight: 436,
      pictureSrc: SvgIcon.error,
      bottomSheetHeight: 294,
      bottomSheetTopPadding: 77,
      childInternal: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(content),
            Container(
              height: 67,
            ),
            buildIKnowButton(context),
          ],
        ),
      ));
}

buildIKnowButton(BuildContext context) => SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: ColorConstant.primaryColor,
        child: Text(
          StringConstant.iKnow,
          style: TextStyle(color: Colors.white, letterSpacing: 8),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
