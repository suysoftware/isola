import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

CupertinoButton oblongTextButton(
    {required String buttonText,
    required Color buttonColor,
    required Gradient buttonGradient,
    required Function() buttonFunc,
    required bool isGradient,
    required int buttonWidth,
    required int buttonHeight,
    required double buttonPadding,
    required double borderWidth,
    required TextStyle textStyle,
    required Color borderColor,
    required double buttonRadius}) {
  return CupertinoButton(
    child: Container(
        decoration: StyleConstants().isGradientBoxDec(
            isGradient: true,
            buttonColor: buttonColor,
            buttonGradient: buttonGradient,
            buttonRadius: buttonHeight + buttonWidth + borderWidth,
            borderWidth: borderWidth,
            borderColor: borderColor),
        width: buttonWidth.w,
        height: buttonHeight.h,
        child: Padding(
          padding: EdgeInsets.all(buttonPadding),
          child: Center(
            child: Text(
              buttonText,
              style: textStyle,
            ),
          ),
        )),
    onPressed: buttonFunc,
  );
}

CupertinoButton oblongIconButton(
    {required Image buttonImage,
    required Color buttonColor,
    required Gradient buttonGradient,
    required Function() buttonFunc,
    required bool isGradient,
    required int buttonWidth,
    required int buttonHeight,
    required double buttonPadding,
    required double borderWidth,
    required Color borderColor}) {
  return CupertinoButton(
    child: Container(
        decoration: StyleConstants().isGradientBoxDec(
            isGradient: true,
            buttonColor: buttonColor,
            buttonGradient: buttonGradient,
            buttonRadius: buttonHeight + buttonWidth + borderWidth,
            borderWidth: borderWidth,
            borderColor: borderColor),
        width: buttonWidth.w,
        height: buttonHeight.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(buttonPadding),
            child: buttonImage,
          ),
        )),
    onPressed: buttonFunc,
  );
}

CupertinoButton oblongTextIconButton(
    {required Image buttonImage,
    required String buttonText,
    required Color buttonColor,
    required Gradient buttonGradient,
    required Function() buttonFunc,
    required TextStyle textStyle,
    required bool isGradient,
    required int buttonWidth,
    required int buttonHeight,
    required double buttonPadding,
    required double borderWidth,
    required Color borderColor}) {
  return CupertinoButton(
    child: Container(
      decoration: StyleConstants().isGradientBoxDec(
          isGradient: true,
          buttonColor: buttonColor,
          buttonGradient: buttonGradient,
          buttonRadius: buttonHeight + buttonWidth + borderWidth,
          borderWidth: borderWidth,
          borderColor: borderColor),
      width: buttonWidth.w,
      height: buttonHeight.h,
      child: Row(
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(buttonPadding, 5.0, buttonPadding, 0.0),
            child: SizedBox(height: 45.0, width: 45.0, child: buttonImage),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: buttonPadding),
            child: Text(
              buttonText,
              style: textStyle,
            ),
          ),
        ],
      ),
    ),
    onPressed: buttonFunc,
  );
}
