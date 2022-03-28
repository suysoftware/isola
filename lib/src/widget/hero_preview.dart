import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isola_app/src/blocs/user_hive_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/page/groupchat/chatting_page.dart';
import 'package:isola_app/src/service/firebase/storage/hive_operations.dart';
import 'package:isola_app/src/service/firebase/storage/tokensystem/single_token_send.dart';
import 'package:isola_app/src/widget/report_sheets.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

import '../model/hive_models/user_hive.dart';
/*
class SearchPageItemDetails extends StatelessWidget {
  final List<dynamic> imageItemList;
  int index;
  final String userUid;
  final IsolaUserMeta userMeta;

  SearchPageItemDetails(
      {required this.imageItemList,
      required this.index,
      required this.userUid,
      required this.userMeta});

  @override
  Widget build(BuildContext context) {
    print('in scaffold ${imageItemList[index].likeList}');
    print('in scaffold ${imageItemList[index].likeValue}');
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(

           
            expandedHeight: 85.h,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*  Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0.1.w, 0.3.h),
                        child: Text(
                          "${imageItemList[index].likeValue}",
                          style: StyleConstants.searchFeedNameTextStyle,
                        ),
                      ),*/
                      Padding(
                        padding: EdgeInsets.fromLTRB(2.6.w, 0, 0, 0.3.h),
                        child: SizedBox(
                          width: 30.sp,
                          height: 30.sp,
                          child: FittedBox(
                            child: LikeButton(
                              isLiked: imageItemList[index]
                                  .likeList
                                  .contains(userUid),
                              likeBuilder: (bool isLiked) {
                                /*    if () {
                                  isLiked = true;
                                }*/

                                return isLiked == true
                                    ? Image.asset(
                                        'asset/img/search_page_like.png')
                                    : Image.asset(
                                        'asset/img/search_like_offmode.png');
                                /*  return Icon(
                                  Icons.heart_broken,
                                  color: isLiked
                                      ? Colors.deepPurpleAccent
                                      : Colors.grey,
                                  size: 15.sp,
                                );*/
                              },
                              likeCount: imageItemList[index].likeValue,
                              likeCountAnimationType:
                                  LikeCountAnimationType.part,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: onLikeButtonTapped,

                              /*  onTap: (bool isLiked) async {
                                if (isLiked) {
                                  ///like ı geri al
                                  print('like geri aldı');
                                  isLiked = false;
                                } else {
                                  /// like et
                                  print('like etti');
                                  isLiked = true;
                                }
                              },*/
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2.6.w, 0, 0, 0.3.h),
                        child: SizedBox(
                          width: 30.sp,
                          height: 30.sp,
                          child: FittedBox(
                            child: LikeButton(
                              bubblesSize: 60.sp,
                              isLiked: imageItemList[index]
                                  .feedTokenList
                                  .contains(userUid),
                              likeBuilder: (bool isGave) {
                                return isGave == true
                                    ? Image.asset(
                                        'asset/img/search_page_token.png',
                                      )
                                    : Image.asset(
                                        'asset/img/search_token_offmode.png');
                                /*  return Icon(
                                  Icons.heart_broken,
                                  color: isLiked
                                      ? Colors.deepPurpleAccent
                                      : Colors.grey,
                                  size: 15.sp,
                                );*/
                              },
                              likeCount: imageItemList[index].feedToken,
                              likeCountAnimationType:
                                  LikeCountAnimationType.part,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: onTokenButtonTapped,
                              /*  onTap: (bool isGave) async {
                            

                                if (isGave) {
                                  //hiçbirşey yapamaz
                                  isGave = false;
                                } else {
                                  //token göndersin
                                  print('token göndersin');
                                  isGave = true;
                                }
                              },*/
                            ),
                          ),
                        ),
                      ),
                      /*
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0.7.w, 0.3.h),
                        child: Text(
                          "${imageItemList[index].feedToken}",
                          style: StyleConstants.searchFeedNameTextStyle,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(2.6.w, 0, 1.w, 0),
                          child: Image.asset(
                            'asset/img/search_page_token.png',
                            width: 16.sp,
                            height: 16.sp,
                          )),*/
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.5.h, 0, 0, 1.5.h),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: ColorConstant.isolaMainGradient,
                              border: Border.all(
                                  color: ColorConstant.transparentColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60.sp))),
                          child: Padding(
                              padding: const EdgeInsets.all(0.5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorConstant.milkColor,
                                    border: Border.all(
                                        color: ColorConstant.transparentColor),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(60.sp))),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: ColorConstant.isolaMainGradient,
                                      border: Border.all(
                                          color:
                                              ColorConstant.transparentColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60.sp))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorConstant.milkColor,
                                            border: Border.all(
                                                color: ColorConstant
                                                    .transparentColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(60.sp))),
                                        child: ClipOval(
                                            child: 100.h >= 700
                                                ? (100.h <= 1100
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            imageItemList[index]
                                                                .userAvatarUrl,
                                                        width: 3.5.h,
                                                        height: 3.5.h,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(CupertinoIcons
                                                                .xmark_square),
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl:
                                                            imageItemList[index]
                                                                .userAvatarUrl,
                                                        width: 35.sp,
                                                        height: 35.sp,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(CupertinoIcons
                                                                .xmark_square),
                                                      ))
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        imageItemList[index]
                                                            .userAvatarUrl,
                                                    width: 45.sp,
                                                    height: 45.sp,
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(CupertinoIcons
                                                                .xmark_square),
                                                  ))),
                                  ),
                                ),
                              )),
                          //    imageUrl: imageUrlList[index].userAvatarUrl,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0.3.h),
                            child: Text(
                              "${imageItemList[index].userName}",
                              style: StyleConstants.searchFeedNameTextStyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 1.5.h),
                            child: Text(
                              "${imageItemList[index].userUniversity}",
                              style:
                                  StyleConstants.searchFeedUniversityTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

/*
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
       */
        ],
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    print('in onTapped ${imageItemList[index].likeList}');
    print('in onTapped ${imageItemList[index].likeValue}');

    /// send your request here
    //buradan final bool success= await sendRequest();
    bool success;

    if (isLiked == true) {
      print('bu likelanmış');

      try {
        //   imageItemList[index].likeList.remove(userUid);
        // imageItemList[index].likeValue--;

        await unLikeFeed(
            targetUid: imageItemList[index].userUid,
            userUid: userUid,
            feedNo: imageItemList[index].feedNo,
            feedLikeList: imageItemList[index].likeList,
            isImage: true);

        success = true;
      } catch (e) {
        success = false;
      }
    } else {
      print('bu likelanmamış');
      try {
        await likeFeed(
            feedLikeList: imageItemList[index].likeList,
            targetUid: imageItemList[index].userUid,
            userUid: userUid,
            feedNo: imageItemList[index].feedNo,
            isImage: true);
        success = true;
      } catch (e) {
        success = false;
      }
    }

    /// if failed, you can do nothing
    return success ? !isLiked : isLiked;

    /* isUnlike == true
        ? (success ? false : isLiked)
        : (success ? !isLiked : isLiked);*/

    //return !isLiked;
  }

  Future<bool> onTokenButtonTapped(bool isGave) async {
    print(
        'onun token listesi in onTapped ${imageItemList[index].feedTokenList}');
    print('onun token miktarı ${imageItemList[index].feedToken}');

    print('///////////');
    print('benim token miktar ${userMeta.userToken}');
    print('//////////');

    /// send your request here
    //buradan final bool success= await sendRequest();
    bool success;

    if (userMeta.userToken > 0) {
      if (isGave == true) {
        success = false;
      } else {
        try {
          singleTokenSend(userUid, imageItemList[index].userUid,
              imageItemList[index].feedNo);
          print('gönderildi');
          /*   await likeFeed(
            feedLikeList: imageItemList[index].likeList,
            targetUid: imageItemList[index].userUid,
            userUid: userUid,
            feedNo: imageItemList[index].feedNo,
            isImage: true);*/

          //token ı var mı diye kontrol et hatta tokenı yoksa başta bu tuşa basamasın
          //token operation

          success = true;
        } catch (e) {
          success = false;
        }
      }

      /// if failed, you can do nothing

    } else {
      success = false;
      print('hata göster tokenı yetmiyor');
    }

    if (success) {
      userMeta.userToken = userMeta.userToken - 1;
    }

    return success ? !isGave : isGave;
    /* isUnlike == true
        ? (success ? false : isLiked)
        : (success ? !isLiked : isLiked);*/

    //return !isLiked;
  }



}
*/