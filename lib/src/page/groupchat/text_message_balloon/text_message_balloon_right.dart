// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/groupchat/chat_interior_page.dart';
import 'package:isola_app/src/page/groupchat/chatting_page.dart';
import 'package:isola_app/src/page/groupchat/text_message_balloon/text_chat_container_right.dart';
import 'package:sizer/sizer.dart';

class TextMessageBalloonRight extends StatelessWidget {
  String memberMessage;
  String memberAvatarUrl;
  Timestamp memberMessageTime;
  String memberName;
  String memberUid;

  TextMessageBalloonRight(
      {Key? key,
      required this.memberMessage,
      required this.memberAvatarUrl,
      required this.memberMessageTime,
      required this.memberName,
      required this.memberUid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSpacing = (memberMessage.length / 50) * 1.4;
    return Row(
      children: [
        sizedBox,
        SizedBox(
          width: 80.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 2.w, 0.0),
                child: TextChatContRight(
                  targetMesaj: memberMessage, messageTime: memberMessageTime,
                ),
              ),
            ],
          ),
        ),
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
                    backgroundColor: ColorConstant.milkColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: CachedNetworkImage(
                      imageUrl:  memberAvatarUrl,
                        fit: BoxFit.cover,
                        height: 35.sp,
                        width: 35.sp,
                         errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                      ),
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
      ],
    );
  }
}
