// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, avoid_init_to_null
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/image_feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/page/groupchat/chatting_page.dart';
import 'package:isola_app/src/service/firebase/storage/explore_history.dart';
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

class SearchDetail extends StatefulWidget {
  final List<dynamic> imageItemList;
  int index;
  final String userUid;
  final IsolaUserMeta userMeta;
  int itemLoc;

  SearchDetail(
      {required this.imageItemList,
      required this.index,
      required this.userUid,
      required this.userMeta,
      required this.itemLoc});
  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //late var searchHistoryData;
  var searchFeed = <FeedMeta>[];
  int loadingValue = 2;
 // var newItemList=<dynamic>[];



  void _onLoading() async {
    List<GridTile> gTile = BasicGridWidget.feedValue;
    if (BasicGridWidget.feedValue.length >= feedAllControl) {
      feedAllControl = 0;
      _refreshController.loadNoData();

      print("aha");
    } else {
      print("bscgridfeedvalue ${BasicGridWidget.feedValue.length}");

      // print("gtilelength ${gTile.length}");
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()

      if (mounted) {
        setState(() {
          BasicGridWidget.gtGetter();
          //   loadingValue = loadingValue + 1;
          //   print(loadingValue);
        });
      }
      _refreshController.loadComplete();
    }
  }

  @override
  void initState() {
    super.initState();

  //  newItemList.addAll(widget.imageItemList.slice(widget.index));
    //newItemList.sort((b, a) => a.feedDate.compareTo(b.feedDate));
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
              ),
            )));
  }
}

int downloadedItem = 0;

class BasicGridWidget extends StatefulWidget {
  const BasicGridWidget({
    Key? key,
    required this.userUid,
    required this.userMeta,
    required this.lastIndex,
    required this.imageItemList,
  }) : super(key: key);

  final String userUid;
  final IsolaUserMeta userMeta;
  final int lastIndex;
  final List<dynamic> imageItemList;

  static void gtGetter() {
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void gtMixer() {
    feedValue.shuffle();

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void gtGetterReset() {
    feedValue.clear();
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void feedAdder(int cac, int mac) {
    feedValue.add(GridTile(cac, mac));
  }

  static var exploreHistoryState = <String>[];

  static void explorerUpdate(User user) async {
    // updateExploreData(exploreHistoryState,user.uid, user.uid);
    await exploreHistoryItemsSave(exploreHistoryState);
  }

  static void explorerGetter(User user) async {
    //  explorerDataGetter(user.uid).then((value) => alreadySeem = value);

    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');

    alreadySeem = userHive.exloreData;
  }

  static var alreadySeem = <dynamic>[];

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      amountUpdater((widget.imageItemList.length) - 8);
    return  widget.imageItemList.isEmpty
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
                    children: [
                      ...BasicGridWidget.feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: BoneOfPost(
                            index: index,
                            width: tile.crossAxisCount * 100,
                            height: tile.mainAxisCount * 100,
                            imageUrl: widget.imageItemList[index]
                                .feedImageUrl,
                            // imageUrl: itemDatas[index].feedImageUrl,
                            userUid: widget.userUid,
                            imageItemList: widget.imageItemList,
                            userMeta: widget.userMeta,
                          ),
                        );
                      })
                    ],
                  );
    
    /*
    StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('image_feeds')
            .limit(BasicGridWidget.feedValue.length + 30)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var searchDatas = <IsolaFeedModel>[];
            var exploreHistory = <String>[];
            //  var allDataAmount = <IsolaFeedModel>[];

            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            //    List<dynamic> itemList =
            //      documents.map((doc) => doc['feed_image']).toList();
          List<dynamic> itemDatas = documents
                .map((doc) => IsolaImageFeedModel(
                    doc['feed_date'],
                    doc['feed_no'],
                    doc['feed_image'],
                    doc['like_list'],
                    doc['like_value'],
                    doc['user_avatar_url'],
                    doc['user_name'],
                    doc['user_uid'],
                    doc['user_loc'],
                    doc['feed_visibility'],
                    doc['feed_report_value'],
                    doc['user_university'],
                    doc['feed_token'],
                    doc['feed_token_list']))
                .toList()..sort((a, b) => a.feedDate.compareTo(b.feedDate));

            //  itemDatas.shuffle();
            //   itemDatas.sort((a, b) => a.feedDate.compareTo(b.feedDate));
/*
            for (IsolaImageFeedModel item in itemDatas) {
              print(item.feedImageUrl);
            }*/
            amountUpdater((itemDatas.length) - 20);
            return itemDatas.isEmpty
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
                    children: [
                      ...BasicGridWidget.feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: BoneOfPost(
                            index: index,
                            width: tile.crossAxisCount * 100,
                            height: tile.mainAxisCount * 100,
                            imageUrl: itemDatas[widget.lastIndex]
                                .feedImageUrl,
                            // imageUrl: itemDatas[index].feedImageUrl,
                            userUid: widget.userUid,
                            imageItemList: itemDatas,
                            userMeta: widget.userMeta,
                          ),
                        );
                      })
                    ],
                  );
          } else if (snapshot.hasError) {
            return const Text('It Error!');
          } else {
            return Center(
                child: CupertinoActivityIndicator(
              animating: true,
              radius: 15.sp,
            ));
          }
        });*/
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
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Icon(CupertinoIcons.xmark_square),
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
      required this.userMeta})
      : super(key: key);

  final String imageUrl;
  final int index;
  final int width;
  final int height;
  final String userUid;
  final List<dynamic> imageItemList;
  final IsolaUserMeta userMeta;

  @override
  Widget build(BuildContext context) {
    print('aasaafafsafs');
    return Stack(
      children: [


        Align(
          
          alignment: Alignment.topRight,
          child:     CupertinoButton(
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
              ),),
        GestureDetector(
          onTap: () {
            print('imageUrl: $imageUrl');
            print('indeks: $index');
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
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        imageItemList[index]
                                                            .userAvatarUrl,
                                                    width: 7.h,
                                                    height: 7.h,
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
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
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(CupertinoIcons
                                                                .xmark_square),
                                                  ))
                                            : CachedNetworkImage(
                                                imageUrl: imageItemList[index]
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
                          style: StyleConstants.searchFeedUniversityTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              )
            ],
          ),
        )
      ],
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
      print(
        imageItemList[index].feedNo,
      );
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
      imageItemList[index].feedNo,
    );
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
