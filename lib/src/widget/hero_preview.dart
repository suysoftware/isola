import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/page/groupchat/chatting_page.dart';
import 'package:isola_app/src/widget/report_sheets.dart';
import 'package:sizer/sizer.dart';

class DetailPage extends StatelessWidget {
  final List<dynamic> imageItemList;
  final int index;
  final String userUid;

  const DetailPage(
      {required this.imageItemList,
      required this.index,
      required this.userUid});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 55.h,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text("${imageItemList[index].userName}"),
                ],
              ),
              background: Hero(
                tag: 'tag ${imageItemList[index]}',
                child: CachedNetworkImage(
                  imageUrl: '${imageItemList[index].feedImageUrl}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              CupertinoButton(
                child: Text('Report'),
                onPressed: () {
                  Navigator.pop(context);
                  showCupertinoModalPopup(
                      context: context,
                      //imageUrlList[index].userName
                      builder: (BuildContext context) => ReportFeedSheet(
                            reporterUid: userUid,
                            
                            isImageFeed: true,
                            feedNo: imageItemList[index].feedNo,
                            targetUid: imageItemList[index].userUid,
                          ));
                },
              )
            ],
          ),
          SliverAppBar(
            //   backgroundColor: ColorConstant.transparentColor,
            title: Container(
              decoration: BoxDecoration(
                  gradient: ColorConstant.isolaMainGradient,
                  border: Border.all(color: ColorConstant.transparentColor),
                  borderRadius: BorderRadius.all(Radius.circular(60.sp))),
              child: Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstant.milkColor,
                        border:
                            Border.all(color: ColorConstant.transparentColor),
                        borderRadius: BorderRadius.all(Radius.circular(60.sp))),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: ColorConstant.isolaMainGradient,
                          border:
                              Border.all(color: ColorConstant.transparentColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(60.sp))),
                      child: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.milkColor,
                                border: Border.all(
                                    color: ColorConstant.transparentColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60.sp))),
                            child: ClipOval(
                                child: 100.h >= 700
                                    ? (100.h <= 1100
                                        ? CachedNetworkImage(
                                            imageUrl: imageItemList[index]
                                                .userAvatarUrl,
                                            width: 13.h,
                                            height: 13.h,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                    CupertinoIcons
                                                        .xmark_square),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: imageItemList[index]
                                                .userAvatarUrl,
                                            width: 35.sp,
                                            height: 35.sp,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                    CupertinoIcons
                                                        .xmark_square),
                                          ))
                                    : CachedNetworkImage(
                                        imageUrl:
                                            imageItemList[index].userAvatarUrl,
                                        width: 45.sp,
                                        height: 45.sp,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Icon(CupertinoIcons.xmark_square),
                                      ))),
                      ),
                    ),
                  )),
              //    imageUrl: imageUrlList[index].userAvatarUrl,
            ),
            backgroundColor: ColorConstant.transparentColor,
            collapsedHeight: 20.h,
            toolbarHeight: 20.h,
            automaticallyImplyLeading: false,
            primary: false,

            /*  flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                SizedBox(width: 5.w,),
                  Text("${imageUrlList[index].userName}"),
                ],
              ),
          /*    background: Hero(
                tag: 'tag ${imageUrlList[index]}',
                child: CachedNetworkImage(
                 imageUrl: '${imageUrlList[index].feedImageUrl}',
                  fit: BoxFit.cover,
                ),
              ),*/
            ),*/
          ),
          SliverAppBar(
            primary: false,
            automaticallyImplyLeading: false,
            backgroundColor: ColorConstant.transparentColor,
            title: Text(
              '${imageItemList[index].userUniversity}',
              style: 100.h >= 1100
                  ? StyleConstants.imageFeedUniversityTabletTextStyle
                  : StyleConstants.imageFeedUniversityTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
