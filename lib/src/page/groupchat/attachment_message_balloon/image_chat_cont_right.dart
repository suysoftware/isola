// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class ImageChatContRight extends StatelessWidget {
  String memberAttachmentUrl;
  String memberName;
  Timestamp messageTime;

  ImageChatContRight({
    Key? key,
    required this.memberAttachmentUrl,
    required this.memberName,
    required this.messageTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     DateFormat dFormat = DateFormat("HH:mm");
    double contCarpan = 100.h <= 1100 ? 15 : 7.5;
    double contWidth = 45.w;
    double contHeight =
        100.h <= 1100 ? (contCarpan * 2 + 4).h : (contCarpan * 2 + 4).h;

    return Container(
      width: contWidth,
      height: contWidth,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: BorderRadius.all(Radius.circular(5.sp))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Center(
                    child: GestureDetector(
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
                                    imageUrl: memberAttachmentUrl,
                                    fit: BoxFit.fill,
                                  ),
                                )))),
                        child: CachedNetworkImage(
                          imageUrl: memberAttachmentUrl,
                          height: contHeight,
                          width: contWidth,
                          errorWidget: (context, url, error) =>
                              Icon(CupertinoIcons.xmark_square),
                        ))),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                  child: Text(
                  '${dFormat.format(DateTime.fromMicrosecondsSinceEpoch(messageTime.microsecondsSinceEpoch.toInt(), isUtc: false))}',
                    style: 100.h <= 1100
                        ? StyleConstants.chatTimeTextStyleRight
                        : StyleConstants.chatTabletTimeTextStyleRight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
