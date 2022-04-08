// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

Widget textWidgetGetter(
  BuildContext context, {
  required String targetMessage,
  required String targetName,
  required int rowLetterValue,
  required TextStyle letterTextStyle,
}) {
  String targetM1 = "";
  String targetM2 = "";
  String targetM3 = "";

  targetM1 = targetMessage.substring(0);
  if (targetMessage.length > rowLetterValue) {
    targetM2 = targetMessage.substring(rowLetterValue);
    targetM1 = targetMessage.substring(0, rowLetterValue);
    if (targetMessage.length > rowLetterValue * 2) {
      targetM2 = targetMessage.substring(rowLetterValue, rowLetterValue * 2);

      targetM3 = targetMessage.substring(rowLetterValue * 2);
    }
  }

  return RichText(
      overflow: TextOverflow.fade,
      maxLines: 3,
      text: TextSpan(children: [
        targetM3 == ""
            ? TextSpan(
                text: "$targetM1\n$targetM2\n$targetM3", style: letterTextStyle)
            : TextSpan(text: "$targetM1\n$targetM2", style: letterTextStyle)
      ]));
}

Widget bioTextWidgetGetter(
  BuildContext context, {
  required String targetMessage,
  required String targetName,
  required int rowLetterValue,
  required TextStyle letterTextStyle,
}) {
  String targetM1 = "";
  String targetM2 = "";
  String targetM3 = "";
  String targetM4 = "";
  int whichLine = 0;
  targetM1 = targetMessage;
  if (targetMessage.length > rowLetterValue) {
    targetM1 = targetMessage.substring(0, rowLetterValue);
    targetM2 = targetMessage.substring(rowLetterValue);
    whichLine = 1;
    if (targetMessage.length > rowLetterValue * 2) {
      whichLine = 2;
      targetM2 = targetMessage.substring(rowLetterValue, rowLetterValue * 2);
      targetM3 = targetMessage.substring(rowLetterValue * 2);
      if (targetMessage.length > rowLetterValue * 3) {
        whichLine = 3;
        targetM3 =
            targetMessage.substring(rowLetterValue * 2, rowLetterValue * 3);
        targetM4 = targetMessage.substring(rowLetterValue * 3);
      }
    }
  }

  return AutoSizeText.rich(
    TextSpan(text: targetMessage),
    style: DefaultTextStyle.of(context).style.copyWith(fontSize: 13.sp),
  );
}
