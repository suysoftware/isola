// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/document_chat_cont_right.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/image_chat_cont_right.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/video_chat_cont_right.dart';
import 'package:sizer/sizer.dart';

class AttachmentMessageBalloonRight extends StatelessWidget {
  String memberAvatarUrl;
  Timestamp memberMessageTime;
  String memberName;
  String memberUid;
  String memberAttachmentUrl;
    bool memberMessageIsImage;
  bool memberMessageIsVideo;
  bool memberMessageIsDocument;

  AttachmentMessageBalloonRight({Key? key, 
    required this.memberAvatarUrl,
    required this.memberMessageTime,
    required this.memberName,
    required this.memberUid,
    required this.memberAttachmentUrl,
    required this.memberMessageIsImage,
      required this.memberMessageIsVideo,
      required this.memberMessageIsDocument
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 

    double imageSpacing = 3;

    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 2.w, 0.0),
                child: memberMessageIsImage == true
                      ? ImageChatContRight(
                          memberAttachmentUrl: memberAttachmentUrl,
                          memberName: memberName, messageTime: memberMessageTime,
                        )
                      : memberMessageIsVideo == true
                          ? VideoChatContRight(
                              memberAttachmentUrl: memberAttachmentUrl,
                              memberName: memberName, messageTime: memberMessageTime,)
                          : DocumentChatContRight(
                              memberAttachmentUrl: memberAttachmentUrl,
                              memberName: memberName, messageTime: memberMessageTime,)
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
                              backgroundColor: ColorConstant.milkColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child:CachedNetworkImage(
                       imageUrl: memberAvatarUrl, fit: BoxFit.cover, height: 35.sp,
                        width: 35.sp,)
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
