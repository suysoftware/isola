
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/page/groupchat/chat_interior_page.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_chat_container_left.dart';
import 'package:sizer/sizer.dart';

class TextMessageBalloonLeft extends StatelessWidget {
  String memberMessage;
  String memberAvatarUrl;
  int memberMessageTime;
  String memberName;
  String memberUid;

  TextMessageBalloonLeft(
      {Key? key, required this.memberMessage,
      required this.memberAvatarUrl,
      required this.memberMessageTime,
      required this.memberName,
      required this.memberUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSpacing = (memberMessage.length / 50) * 1.4;
    return Row(
      children: [
        sizedBox,
        Column(
          children: [
            Container(
              height: 100.h >= 1100 ? 21.sp : 30.sp,
              width: 100.h >= 1100 ? 21.sp : 30.sp,
              decoration: BoxDecoration(
                  gradient: ColorConstant.isolaMainGradient,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: BorderRadius.all(Radius.circular(20.sp))),
              child: Padding(
                padding: const EdgeInsets.all(0.5),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.milkColor,
                      border: Border.all(color: ColorConstant.transparentColor),
                      borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                  child: CircleAvatar(
                       radius: 13.sp,
                            backgroundColor:ColorConstant.milkColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: Image.network(memberAvatarUrl
                      ,  fit: BoxFit.cover, height: 35.sp,
                        width: 35.sp,),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: imageSpacing.h,
            )
          ],
        ),
        SizedBox(
          width: 80.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 1.w),
                child: Text(
                  memberName,
                  style: 100.h <= 1100
                      ? StyleConstants.chatNameTextStyle1
                      : StyleConstants.chatTabletNameTextStyle1,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 0.0),
                child: TextChatContLeft(
                  targetMesaj: memberMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
