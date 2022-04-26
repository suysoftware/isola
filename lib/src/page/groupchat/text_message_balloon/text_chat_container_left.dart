// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class TextChatContLeft extends StatelessWidget {
  String targetMesaj;
  Timestamp messageTime;
  TextChatContLeft(
      {Key? key, required this.targetMesaj, required this.messageTime})
      : super(key: key);
  // ignore: non_constant_identifier_names
  static final RegExp REGEX_EMOJI = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  late bool isJustEmoji;

  @override
  Widget build(BuildContext context) {
    DateFormat dFormat = DateFormat("HH:mm");

        if (targetMesaj.length == 2 &&
        REGEX_EMOJI.allMatches(targetMesaj).isNotEmpty) {
      isJustEmoji = true;
    } else {
      isJustEmoji = false;
    }
    double contHeight = 100.h <= 1100
        ? ((targetMesaj.length < 50 ? 1 : targetMesaj.length / 50) + 1.0)
        : ((targetMesaj.length / 30) + 0.6);
    double topRight = (contHeight * 2 + 6.5) * 3;
    double bottomRight = (contHeight * 2 + 6.5) * 3;
    double bottomLeft = (contHeight + 8) * 3;
    return Container(
            width: isJustEmoji == true ? 18.w : 70.w,
      height: isJustEmoji == true
          ? ((contHeight * 2 + 6).h)
          : ((contHeight * 2 + 4).h),
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
                   style: isJustEmoji == true
                        ? TextStyle(fontSize: 30.sp)
                        : (100.h >= 1100
                            ? StyleConstants.targetTabletChatMessageTextStyle
                            : StyleConstants.targetChatMessageTextStyle)),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.w, 0.3.h),
                  child: Text(
                    dFormat.format(DateTime.fromMicrosecondsSinceEpoch(
                        messageTime.microsecondsSinceEpoch.toInt(),
                        isUtc: false)),
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
