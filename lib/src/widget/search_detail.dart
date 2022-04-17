// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, avoid_init_to_null
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/extensions/locale_keys.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/service/firebase/storage/deleting/feed_delete.dart';
import 'package:isola_app/src/utils/router.dart';
import 'package:isola_app/src/widget/report_sheets.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import '../constants/style_constants.dart';
import '../service/firebase/storage/hive_operations.dart';
import '../service/firebase/storage/tokensystem/single_token_send.dart';

int feedAllControl = 0;
void amountUpdater(int updateValue) async {
  feedAllControl = updateValue;
}

// ignore: must_be_immutable
class SearchDetail extends StatefulWidget {
  final List<dynamic> imageItemList;
  int index;
  final String userUid;
  final IsolaUserMeta userMeta;
  int itemLoc;
  bool isProfile;

  SearchDetail(
      {Key? key,
      required this.imageItemList,
      required this.index,
      required this.userUid,
      required this.userMeta,
      required this.itemLoc,
      required this.isProfile})
      : super(key: key);
  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //late var searchHistoryData;

  int loadingValue = 2;
  // var newItemList=<dynamic>[];

  void _onLoading() async {
    List<GridTile> gTile = BasicGridWidget.feedValue;
    if (BasicGridWidget.feedValue.length >= feedAllControl) {
      feedAllControl = 0;
      _refreshController.loadNoData();
    } else {
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()

      if (mounted) {
        setState(() {
          BasicGridWidget.gtGetter();
        });
      }
      _refreshController.loadComplete();
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.isProfile == true) {
      BasicGridWidget.feedValue.clear();

      for (var i = 0; i < widget.imageItemList.length; i++) {
        BasicGridWidget.feedValue.add(const GridTile(3, 5));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: ColorConstant.milkColor,
          automaticallyImplyLeading: true,
        ),
        child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            footer: const ClassicFooter(),
            controller: _refreshController,
            onLoading: _onLoading,
            child: Container(
              color: ColorConstant.themeGrey,
              child: BasicGridWidget(
                key: widget.key,
                userUid: widget.userMeta.userUid,
                userMeta: widget.userMeta,
                lastIndex: widget.itemLoc,
                imageItemList: widget.imageItemList,
                isProfile: widget.isProfile,
              ),
            )));
  }
}

int downloadedItem = 0;

class BasicGridWidget extends StatefulWidget {
  const BasicGridWidget(
      {Key? key,
      required this.userUid,
      required this.userMeta,
      required this.lastIndex,
      required this.imageItemList,
      required this.isProfile})
      : super(key: key);

  final String userUid;
  final IsolaUserMeta userMeta;
  final int lastIndex;
  final List<dynamic> imageItemList;
  final bool isProfile;

  static void gtGetter() {
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static const tiles2 = [
    GridTile(3, 5),
    GridTile(3, 5),
    GridTile(3, 5),
    GridTile(3, 5),
    GridTile(3, 5),
    GridTile(3, 5),
    GridTile(3, 5),
    GridTile(3, 5),
  ];

  static var feedValue = <GridTile>[
    const GridTile(3, 5),
    const GridTile(3, 5),
    const GridTile(3, 5),
    const GridTile(3, 5),
    const GridTile(3, 5),
    const GridTile(3, 5),
    const GridTile(3, 5),
    const GridTile(3, 5),
  ];

  @override
  State<BasicGridWidget> createState() => _BasicGridWidgetState();
}

class _BasicGridWidgetState extends State<BasicGridWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.imageItemList.length < BasicGridWidget.feedValue.length &&
        widget.imageItemList.isNotEmpty) {
      int deleteNeed =
          BasicGridWidget.feedValue.length - widget.imageItemList.length;

      for (var i = 0; i < deleteNeed; i++) {
        BasicGridWidget.feedValue.removeLast();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    amountUpdater((widget.imageItemList.length) - 8);

    return widget.imageItemList.isEmpty
        ? Center(
            child: Column(
            children: [
              Icon(
                CupertinoIcons.photo,
                size: 65.sp,
                color: ColorConstant.softGrey,
              ),
              const Text("You have not image")
            ],
          ))
        : StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 2.h,
            children: [
              ...BasicGridWidget.feedValue.mapIndexed((index, tile) {
                return StaggeredGridTile.count(
                  crossAxisCellCount: tile.crossAxisCount,
                  mainAxisCellCount: tile.mainAxisCount,
                  child: BoneOfPost(
                    index: index,
                    width: tile.crossAxisCount * 100,
                    height: tile.mainAxisCount * 100,
                    imageUrl: widget.imageItemList[index].feedImageUrl,
                    userUid: widget.userUid,
                    imageItemList: widget.imageItemList,
                    userMeta: widget.userMeta,
                    isProfile: widget.isProfile,
                  ),
                );
              })
            ],
          );
  }
}

class PostTile extends StatefulWidget {
  const PostTile(
      {Key? key,
      required this.imageUrl,
      required this.index,
      required this.width,
      required this.height,
      required this.imageItemList,
      required this.userUid,
      required this.userMeta})
      : super(key: key);

  final String imageUrl;
  final int index;
  final int width;
  final int height;
  final List<dynamic> imageItemList;
  final String userUid;
  final IsolaUserMeta userMeta;
  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: ColorConstant.isolaMainGradient,
            border: Border.all(color: ColorConstant.transparentColor),
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.milkColor,
                border: Border.all(color: ColorConstant.transparentColor),
                borderRadius: const BorderRadius.all(Radius.circular(15.0))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 100.h > 1150 ? 100.h : (100.h < 750 ? 90.h : 80.h),
                width: 100.w,
                child: FittedBox(
                  fit: BoxFit.cover,

                 // child:Image.network(widget.imageUrl, fit: BoxFit.cover,),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
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
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

class BoneOfPost extends StatelessWidget {
  const BoneOfPost(
      {Key? key,
      required this.imageUrl,
      required this.index,
      required this.width,
      required this.height,
      required this.userUid,
      required this.imageItemList,
      required this.userMeta,
      required this.isProfile})
      : super(key: key);

  final String imageUrl;
  final int index;
  final int width;
  final int height;
  final String userUid;
  final List<dynamic> imageItemList;
  final IsolaUserMeta userMeta;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Timestamp dateStamp = imageItemList[index].feedDate;

            var ss = DateTime.fromMicrosecondsSinceEpoch(
                dateStamp.microsecondsSinceEpoch);
          },
          child: PostTile(
            index: index,
            width: width,
            height: height,
            imageUrl: imageUrl,
            userUid: userUid,
            imageItemList: imageItemList,
            userMeta: userMeta,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CupertinoButton(
              child:
                  isProfile == true && imageItemList[index].userUid == userUid
                      ? Icon(
                          CupertinoIcons.trash,
                          size: 20.sp,
                          color: ColorConstant.iGradientMaterial4,
                        )
                      : Icon(
                          CupertinoIcons.exclamationmark_circle,
                          color: ColorConstant.iGradientMaterial4,
                          size: 23.sp,
                        ),
              onPressed: isProfile == true &&
                      imageItemList[index].userUid == userUid
                  ? () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                actions: [
                                  CupertinoButton(
                                      child:  Text('${LocaleKeys.main_delete.tr()} Post'),
                                      onPressed: () {
                                        imageFeedDelete(
                                            imageItemList[index].feedNo,
                                            userUid);

                                        Navigator.pushReplacementNamed(
                                            context, navigationBar);
                                      }),
                                  CupertinoButton(
                                      child: const Text('Back'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ],
                              ));
                    }
                  : () {
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
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      width: 45.sp,
                      height: 45.sp,
                      child: FittedBox(
                        child: LikeButton(
                          isLiked:
                              imageItemList[index].likeList.contains(userUid),
                          likeBuilder: (bool isLiked) {
                            /*    if () {
                                    isLiked = true;
                                  }*/

                            return isLiked == true
                                ? Image.asset('asset/img/search_page_like.png')
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
                          countDecoration: (Widget count, int? tokenCount) {
                            return Text(tokenCount.toString(),
                                style: 100.h > 900
                                    ? StyleConstants
                                        .searchFeedLikeAndTokenTabletTextStyle
                                    : StyleConstants
                                        .searchFeedLikeAndTokenTextStyle);
                          },
                          likeCountAnimationType: LikeCountAnimationType.part,
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
                      width: 45.sp,
                      height: 45.sp,
                      child: FittedBox(
                        child: LikeButton(
                          bubblesSize: 60.sp,
                          isLiked: imageItemList[index]
                              .feedTokenList
                              .contains(userUid),
                          countDecoration: (Widget count, int? likeCount) {
                            return Text(likeCount.toString(),
                                style: 100.h > 900
                                    ? StyleConstants
                                        .searchFeedLikeAndTokenTabletTextStyle
                                    : StyleConstants
                                        .searchFeedLikeAndTokenTextStyle);
                          },
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
                          likeCountAnimationType: LikeCountAnimationType.part,
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
                    padding: EdgeInsets.fromLTRB(8.w, 0, 0, 2.5.h),
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
                                            color:
                                                ColorConstant.transparentColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60.sp))),
                                    child: ClipOval(
                                        child: 100.h >= 700
                                            ? (100.h <= 1100
                                                ? 
                                                
                                                /* Image.network(
                                                  
                                                    imageItemList[index]
                                                        .userAvatarUrl,
                                                    width: 7.h,
                                                    height: 7.h,
                                                    fit: BoxFit.cover,
                                                  
                                                  )
                                                : Image.network(
                                                    imageItemList[index]
                                                        .userAvatarUrl,
                                                    width: 35.sp,
                                                    height: 35.sp,
                                                    fit: BoxFit.cover,
                                                  ))
                                            : Image.network(
                                                imageItemList[index]
                                                    .userAvatarUrl,
                                                width: 35.sp,
                                                height: 35.sp,
                                                fit: BoxFit.cover,
                                              )

*/



                                                CachedNetworkImage(
                                                    imageUrl:
                                                        imageItemList[index]
                                                            .userAvatarUrl,
                                                    useOldImageOnUrlChange:
                                                        true,
                                                    width: 7.h,
                                                    height: 7.h,
                                                    
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(
                                                            CupertinoIcons
                                                                .xmark_square),
                                                    cacheManager:
                                                        CacheManager(Config(
                                                      "cachedImageFiles",
                                                      stalePeriod:
                                                          const Duration(
                                                              days: 3),
                                                      //one week cache period
                                                    ),),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        imageItemList[index]
                                                            .userAvatarUrl,
                                                            useOldImageOnUrlChange: true,
                                                    width: 35.sp,
                                                    height: 35.sp,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(
                                                            CupertinoIcons
                                                                .xmark_square),
                                                    cacheManager:
                                                        CacheManager(Config(
                                                      "cachedImageFiles",
                                                      stalePeriod:
                                                          const Duration(
                                                              days: 3),
                                                      //one week cache period
                                                    )),
                                                  ))
                                            : CachedNetworkImage(
                                                imageUrl: imageItemList[index]
                                                    .userAvatarUrl,
                                                width: 45.sp,
                                                height: 45.sp,
                                                fit: BoxFit.cover,
                                                useOldImageOnUrlChange: true,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const Icon(CupertinoIcons
                                                        .xmark_square),
                                                cacheManager:
                                                    CacheManager(Config(
                                                  "cachedImageFiles",
                                                  stalePeriod:
                                                      const Duration(days: 3),
                                                  //one week cache period
                                                )),
                                              )
                                              
                                              
                                              
                                              
                                              
                                              )
                                              ),
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
                          style: 100.h > 900
                              ? StyleConstants.searchFeedNameTabletTextStyle
                              : StyleConstants.searchFeedNameTextStyle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 1.5.h),
                        child: Text(
                          "${imageItemList[index].userUniversity}",
                          style: 100.h > 900
                              ? StyleConstants
                                  .searchFeedUniversityTabletTextStyle
                              : StyleConstants.searchFeedUniversityTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              100.h > 1150
                  ? SizedBox(
                      height: 20.h,
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    bool success;

    if (isLiked == true) {
      try {
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
  }

  Future<bool> onTokenButtonTapped(bool isGave) async {
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
    }

    if (success) {
      userMeta.userToken = userMeta.userToken - 1;
    }

    return success ? !isGave : isGave;
  }
}
