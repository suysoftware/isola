
// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class TextChatContLeft extends StatelessWidget {
  String targetMesaj;
  TextChatContLeft({Key? key, required this.targetMesaj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contHeight = 100.h <= 1100
        ? ((targetMesaj.length < 50 ? 1 : targetMesaj.length / 50) + 1.0)
        : ((targetMesaj.length / 30) + 0.6);
    double topRight = (contHeight * 2 + 6.5) * 3;
    double bottomRight = (contHeight * 2 + 6.5) * 3;
    double bottomLeft = (contHeight + 8) * 3;
    return Container(
      width: 70.w,
      height: 100.h <= 1100 ? (contHeight * 2 + 4).h : (contHeight * 2 + 4).h,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRight),
            bottomRight: Radius.circular(bottomRight),
            bottomLeft: Radius.circular(bottomLeft),
          )),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: ColorConstant.messageBoxGrey,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(topRight),
                bottomRight: Radius.circular(bottomRight),
                bottomLeft: Radius.circular(bottomLeft),
              )),
          child: Stack(
            children: [
              Padding(
                padding: 100.h >= 1100
                    ? const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0)
                    : const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                child: RichText(
                  text: TextSpan(
                      text: targetMesaj,
                      style: 100.h >= 1100
                          ? StyleConstants.targetTabletChatMessageTextStyle
                          : StyleConstants.targetChatMessageTextStyle),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.w, 0.3.h),
                  child: Text(
                    "11:30",
                    style: 100.h <= 1100
                        ? StyleConstants.chatTimeTextStyleLeft
                        : StyleConstants.chatTabletTimeTextStyleLeft,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
