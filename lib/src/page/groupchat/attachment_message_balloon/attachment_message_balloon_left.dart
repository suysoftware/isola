// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/document_chat_cont_left.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/image_chat_cont_left.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/video_chat_cont_left.dart';
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
  TextStyle targetTextStyle;

  AttachmentMessageBalloonLeft(
      {Key? key,
      required this.memberAvatarUrl,
      required this.memberMessageTime,
      required this.memberName,
      required this.memberUid,
      required this.memberMessageIsImage,
      required this.memberMessageIsVideo,
      required this.memberMessageIsDocument,
      required this.memberAttachmentUrl,
      required this.targetTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSpacing = 3;
    return Row(
      children: [
        sizedBox,
        Column(
          children: [
            GestureDetector(
              onTap: () => showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoPageScaffold(
                      navigationBar: const CupertinoNavigationBar(
                        automaticallyImplyLeading: true,
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CachedNetworkImage(
                          imageUrl: memberAvatarUrl,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              const Icon(CupertinoIcons.xmark_square),
                          cacheManager: CacheManager(Config(
                            "cachedImageFiles",
                            stalePeriod: const Duration(days: 3),
                            //one week cache period
                          )),
                        ),
                      )))),
              child: Container(
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
                        border:
                            Border.all(color: ColorConstant.transparentColor),
                        borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                    child: CircleAvatar(
                      backgroundColor: ColorConstant.milkColor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: CachedNetworkImage(
                          imageUrl: memberAvatarUrl,
                          errorWidget: (context, url, error) =>
                              const Icon(CupertinoIcons.xmark_square),
                          cacheManager: CacheManager(Config(
                            "cachedImageFiles",
                            stalePeriod: const Duration(days: 3),
                            //one week cache period
                          )),
                        ),
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
        SizedBox(
          width: 80.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 0.0),
                child: Text(memberName, style: targetTextStyle),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 0.0, 0.0, 0.0),
                  child: memberMessageIsImage == true
                      ? ImageChatContLeft(
                          memberAttachmentUrl: memberAttachmentUrl,
                          memberName: memberName,
                          messageTime: memberMessageTime,
                        )
                      : memberMessageIsVideo == true
                          ? VideoChatContLeft(
                              memberAttachmentUrl: memberAttachmentUrl,
                              memberName: memberName,
                              messageTime: memberMessageTime,
                            )
                          : DocumentChatContLeft(
                              memberAttachmentUrl: memberAttachmentUrl,
                              memberName: memberName,
                              messageTime: memberMessageTime,
                            )),
            ],
          ),
        ),
      ],
    );
  }
}
