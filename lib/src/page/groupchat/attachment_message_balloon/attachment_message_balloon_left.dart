// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/document_chat_cont_left.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/image_chat_cont_left.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/video_chat_cont_left.dart';
import 'package:isola_app/src/page/groupchat/chat_interior_page.dart';
import 'package:isola_app/src/page/groupchat/chatting_page.dart';
import 'package:sizer/sizer.dart';

class AttachmentMessageBalloonLeft extends StatelessWidget {
  String memberAvatarUrl;
  Timestamp memberMessageTime;
  String memberName;
  String memberUid;
  bool memberMessageIsImage;
  bool memberMessageIsVideo;
  bool memberMessageIsDocument;
  String memberAttachmentUrl;

  AttachmentMessageBalloonLeft(
      {Key? key, required this.memberAvatarUrl,
      required this.memberMessageTime,
      required this.memberName,
      required this.memberUid,
      required this.memberMessageIsImage,
      required this.memberMessageIsVideo,
      required this.memberMessageIsDocument,
      required this.memberAttachmentUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSpacing = 3;
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
                              backgroundColor: ColorConstant.milkColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: CachedNetworkImage(
                        imageUrl:memberAvatarUrl, errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),),
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
                padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 0.0),
                child: Text(
                  memberName,
                  style: 100.h <= 1100
                      ? StyleConstants.chatNameTextStyle1
                      : StyleConstants.chatTabletNameTextStyle1,
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 0.0),
                  child: memberMessageIsImage == true
                      ? ImageChatContLeft(
                          memberAttachmentUrl: memberAttachmentUrl,
                          memberName: memberName,
                        )
                      : memberMessageIsVideo == true
                          ? VideoChatContLeft(
                              memberAttachmentUrl: memberAttachmentUrl,
                              memberName: memberName)
                          : DocumentChatContLeft(
                              memberAttachmentUrl: memberAttachmentUrl,
                              memberName: memberName)),
            ],
          ),
        ),
      ],
    );
  }
}
