// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class ImageChatContLeft extends StatelessWidget {
  String memberAttachmentUrl;
  String memberName;
  ImageChatContLeft(
      {Key? key, required this.memberAttachmentUrl, required this.memberName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
                color: ColorConstant.messageBoxGrey,
                border: Border.all(color: ColorConstant.transparentColor),
                borderRadius: BorderRadius.all(Radius.circular(5.sp))),
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
                                        imageUrl:
                                        memberAttachmentUrl,
                                        fit: BoxFit.fill,
                                         errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                                      ),
                                    )))),
                            child: CachedNetworkImage(
                              imageUrl:
                              memberAttachmentUrl,
                              height: contHeight,
                              width: contWidth,
                               errorWidget:
                                                      (context, url, error) =>
                                                          Icon(CupertinoIcons
                                                              .xmark_square),
                            ))),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
                      child: Text(
                        "11:30",
                        style: 100.h <= 1100
                            ? StyleConstants.chatTimeTextStyleLeft
                            : StyleConstants.chatTabletTimeTextStyleLeft,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
