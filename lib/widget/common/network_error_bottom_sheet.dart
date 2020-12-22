import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'normal_bottom_sheet.dart';

buildNetworkErrorBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildBottomSheetBody(context);
      }
  );
}

_buildBottomSheetBody(BuildContext context) {
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
            Text(StringConstant.networkError),
            Container(height: 67,),
            buildIKnowButton(context),
          ],
        ),
      )
  );
}

buildIKnowButton(BuildContext context) =>
    SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
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
