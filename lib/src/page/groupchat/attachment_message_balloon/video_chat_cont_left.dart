// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/page/groupchat/attachment_message_balloon/video_player_page.dart';
import 'package:sizer/sizer.dart';

class VideoChatContLeft extends StatelessWidget {
  String memberAttachmentUrl;
  String memberName;
  Timestamp messageTime;
  VideoChatContLeft(
      {Key? key,
      required this.memberAttachmentUrl,
      required this.memberName,
      required this.messageTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dFormat = DateFormat("HH:mm");
    double contCarpan = 100.h <= 1100 ? 10 : 5;
    double contWidth = 45.w;
    double contHeight =
        100.h <= 1100 ? (contCarpan * 2 + 4).h : (contCarpan * 2 + 4).h;

    return Container(
      width: contWidth,
      height: contHeight,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: const BorderRadius.all(Radius.circular(14.0))),
      child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: ColorConstant.messageBoxGrey,
                border: Border.all(color: ColorConstant.transparentColor),
                borderRadius: const BorderRadius.all(Radius.circular(14.0))),
            child: Container(
              padding: const EdgeInsets.all(1.0),
              child: Stack(
                children: [
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
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () => showCupertinoDialog(
                              context: context,
                              builder: (context) => VideoApp(
                                    memberAttachmentUrl: memberAttachmentUrl,
                                    memberName: memberName,
                                  )),
                          child: SizedBox(
                              height: contHeight,
                              width: contWidth,
                              child: FittedBox(
                                  child: Icon(
                                CupertinoIcons.video_camera,
                                color: ColorConstant.softGrey,
                              ))))),
                ],
              ),
            ),
          )),
    );
  }
}
