import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NormalBottomSheetContainer extends Container {

  final double? bottomCardRadius;
  final double? totalHeight;
  final String? pictureSrc;
  final double? bottomSheetTopPadding;
  final double? bottomSheetHeight;
  final Widget? childInternal;

  NormalBottomSheetContainer({
    this.totalHeight,
    this.bottomSheetTopPadding,
    this.bottomSheetHeight,
    this.bottomCardRadius,
    this.pictureSrc,
    this.childInternal
  });
  
  @override
  Widget get child => Stack(
    children: [
      Positioned(
          top: totalHeight! - bottomSheetHeight!,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bottomCardRadius!),
                topRight: Radius.circular(bottomCardRadius!),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: bottomSheetTopPadding!
              ),
              child: childInternal,
            )
          )
      ),
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(pictureSrc!)
      ),
    ],
  );
  
}



