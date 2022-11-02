// ignore_for_file: avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:sizer/sizer.dart';

class DocumentChatContLeft extends StatelessWidget {
  String memberAttachmentUrl;
  String memberName;
  Timestamp messageTime;
  DocumentChatContLeft(
      {Key? key,
      required this.memberAttachmentUrl,
      required this.memberName,
      required this.messageTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dFormat = DateFormat("HH:mm");
    return Container(
      width: 20.w,
      height: 14.h,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: ColorConstant.messageBoxGrey,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          child: Container(
            padding: const EdgeInsets.all(1.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 2.w, 0.3.h),
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
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoPageScaffold(
                              navigationBar: const CupertinoNavigationBar(
                                automaticallyImplyLeading: true,
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: const PDF().cachedFromUrl(
                                  memberAttachmentUrl,
                                  placeholder: (progress) =>
                                      Center(child: Text('$progress %')),
                                  errorWidget: (error) =>
                                      Center(child: Text(error.toString())),
                                ),
                              ))));
                    },
                    child: Center(
                      child: SizedBox(
                          height: 100.h <= 700 ? 8.h : 12.h,
                          width: 100.h <= 700 ? 12.w : 18.w,
                          child: const FittedBox(
                              child: Icon(
                            CupertinoIcons.doc_fill,
                            color: ColorConstant.themeGrey,
                          ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
