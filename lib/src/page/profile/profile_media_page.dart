// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:collection/collection.dart';
import 'package:isola_app/src/model/enum/ref_enum.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/image_feed_meta.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_display.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../../model/user/user_meta.dart';
import '../../widget/search_detail.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/blocs/user_all_cubit.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/image_feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/model/user/user_meta.dart';
import 'package:isola_app/src/service/firebase/storage/explore_history.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_search_feed.dart';
import 'package:isola_app/src/widget/liquid_progress_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

int feedAllControl = 0;

bool aDeleted = false;

void amountUpdater(int updateValue) async {
  feedAllControl = updateValue;
}

void deletedStatusChanger() async {
  aDeleted = !aDeleted;
}

class ProfileMediaPage extends StatefulWidget {
  const ProfileMediaPage({Key? key, required this.user, required this.userAll})
      : super(key: key);
  final User user;
  final IsolaUserAll userAll;
  @override
  _ProfileMediaPageState createState() => _ProfileMediaPageState();
}

class _ProfileMediaPageState extends State<ProfileMediaPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //late var searchHistoryData;
  var searchFeed = <FeedMeta>[];
  int loadingValue = 2;

  //dynamic searchHistory = <String>[];

  //void _historyGetter(List _list) {
  // searchHistoryData = _list;
  // print(_list);
  //}
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    // if failed,use refreshFailed()
    setState(() {
      // BasicGridWidget.explorerUpdate(widget.user);
      // BasicGridWidget.explorerGetter(widget.user);

      BasicGridWidget.gtGetterReset();
    });
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    List<GridTile> gTile = BasicGridWidget.feedValue;
    if (BasicGridWidget.feedValue.length >= feedAllControl) {
      /*
      setState(() {
        //   BasicGridWidget.gtMixer();
        BasicGridWidget.explorerGetter(widget.user);
        BasicGridWidget.gtGetterReset();
        _refreshController.loadComplete();
        // _onRefresh();
      });*/
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
          //   BasicGridWidget.gtGetter();
          BasicGridWidget.gtGetterWithValue(
              feedAllControl - BasicGridWidget.feedValue.length);
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

    print(widget.userAll.isolaUserMeta.userToken);
    widget.userAll.isolaUserMeta.userToken =
        context.read<UserAllCubit>().state.isolaUserMeta.userToken;
    print('////////');
    print(widget.userAll.isolaUserMeta.userToken);
    print('////////');
    /*  if (feedAllControl != 0) {
      for (var i = 0; i < feedAllControl; i++) {
        BasicGridWidget.feedValue.add(GridTile(1, 2));
      }
    }*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: const ClassicFooter(),
          header: const ClassicHeader(),
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          controller: _refreshController,
          child: Container(
            color: ColorConstant.themeGrey,
            child: BasicGridWidget(
              key: widget.key,
              userUid: widget.userAll.isolaUserMeta.userUid,
              userAll: widget.userAll,
            ),
          )),
    );
  }
}

int downloadedItem = 0;

class BasicGridWidget extends StatefulWidget {
  const BasicGridWidget(
      {Key? key, required this.userUid, required this.userAll})
      : super(key: key);

  final String userUid;
  final IsolaUserAll userAll;

  static void gtMixer() {
    feedValue.shuffle();

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void feedAdder(int cac, int mac) {
    feedValue.add(GridTile(cac, mac));
  }

  static var exploreHistoryState = <String>[];

  static void explorerUpdate(User user) async {
    // updateExploreData(exploreHistoryState,user.uid, user.uid);
   /// await exploreHistoryItemsSave(exploreHistoryState);
  }

  static void gtGetterReset() {
    feedValue.clear();
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void gtGetter() {
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void gtGetterWithValue(int value) {
    for (var i = 0; i < value; i++) {
      feedValue.add(
        GridTile(1, 2),
      );
    }

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

  static void explorerGetter(User user) async {
    //  explorerDataGetter(user.uid).then((value) => alreadySeem = value);

    var box = await Hive.openBox('userHive');

    UserHive userHive = box.get('datetoday');

    alreadySeem = userHive.exloreData;
  }

  static var alreadySeem = <dynamic>[];

  static const tiles2 = [
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
  ];

  static var feedValue = <GridTile>[
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
    GridTile(1, 2),
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
    print(BasicGridWidget.feedValue.length);
    print(BasicGridWidget.feedValue.length);
    print(BasicGridWidget.feedValue.length);
    print(BasicGridWidget.feedValue.length);
    print(BasicGridWidget.feedValue.length);
    print(BasicGridWidget.feedValue.length);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feeds')
            .doc(widget.userUid)
            .collection('image_feeds')
            .orderBy('feed_date', descending: true)
            .limit(BasicGridWidget.feedValue.length + 9)
            .snapshots(),
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
                    widget.userAll.isolaUserDisplay.avatarUrl,
                    doc['user_name'],
                    doc['user_uid'],
                    doc['user_loc'],
                    doc['feed_visibility'],
                    doc['feed_report_value'],
                    doc['user_university'],
                    doc['feed_token'],
                    doc['feed_token_list']))
                .toList();

            if (itemDatas.length < BasicGridWidget.feedValue.length&&itemDatas.isNotEmpty) {
              int deleteNeed =
                  BasicGridWidget.feedValue.length - itemDatas.length;


                  for (var i = 0; i < deleteNeed; i++) {

                      BasicGridWidget.feedValue.removeLast();
                    
                  }
            }

            print(itemDatas);
            print('////////////');
            if (aDeleted == true) {
              BasicGridWidget.feedValue.removeLast();
              aDeleted = false;
            }

            // for (var i = 0; i < itemDatas.length; i++) {
            // BasicGridWidget.feedValue.add(GridTile(1, 2));
            // }
            //  itemDatas.shuffle();
            // itemDatas.sort((a, b) => a.feedDate.compareTo(b.feedDate));
/*
            for (IsolaImageFeedModel item in itemDatas) {
              print(item.feedImageUrl);
            }*/
            amountUpdater(itemDatas.length);
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
                          child: GestureDetector(
                            onTap: () {
                              print('ilk $index');
                              _openDetail(context, index, itemDatas,
                                  widget.userUid, widget.userAll.isolaUserMeta, index);
                            },
                            child: ImageTile(
                              index: index,
                              width: tile.crossAxisCount * 100,
                              height: tile.mainAxisCount * 100,
                              //   imageUrl: searchDatas[index].feedImageUrl,
                              imageUrl: itemDatas[index].feedImageUrl,
                            ),
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
        });
  }
}

_openDetail(context, index, List<dynamic> imageItemList, String userUid,
    IsolaUserMeta userMeta, int sira) {
  print(userMeta.userToken);
  print(sira);
  //imageItemList.sort((a, b) => a.feedDate.compareTo(b.feedDate));

  List<dynamic> slicedList = imageItemList.slice(sira);

  final route = CupertinoPageRoute(
    builder: (context) => SearchDetail(
      index: index,
      imageItemList: slicedList,
      userUid: userUid,
      userMeta: userMeta,
      itemLoc: sira,
      isProfile: true,
    ),
  );
  Navigator.push(context, route);
}

class ImageTile extends StatefulWidget {
  const ImageTile({
    Key? key,
    required this.imageUrl,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String imageUrl;
  final int index;
  final int width;
  final int height;

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isScope = false;

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
              borderRadius: BorderRadius.circular(15.0),
              child: Hero(
                tag: 'tag ${widget.imageUrl}',
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

/*



 return StreamBuilder<dynamic>(
        stream: refSearch.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var searchDatas = <FeedMeta>[];
            var exploreHistory = <String>[];
            var allDataAmount = <FeedMeta>[];
            downloadedItem = downloadedItem + 1;
            var gettingSearch = event.data.snapshot.value as Map;

            gettingSearch.forEach((key, value) {
              var imageFeed = FeedMeta.fromJson(value);
              allDataAmount.add(imageFeed);

              if (imageFeed.feedIsImage == true &&
                  exploreHistory.length <= feedValue.length) {
                if (exploreHistory.contains(imageFeed.feedNo) != true) {
                  if (alreadySeem.contains(imageFeed.feedNo) != true) {
                    searchDatas.add(imageFeed);
                    // String explorerItem = imageFeed.feedNo;
                    exploreHistory.add(imageFeed.feedNo);

                    if (exploreHistoryState.contains(imageFeed.feedNo) !=
                        true) {
                      exploreHistoryState.add(imageFeed.feedNo);
                    }

                    print("Feed miktarı ${exploreHistory.length}");
                    print("Feed No :  ${imageFeed.feedNo}");
                  }
                }
              }
            });

            amountUpdater((allDataAmount.length) - 20);

            return StaggeredGrid.count(
              crossAxisCount: 3,
              children: [
                ...feedValue.mapIndexed((index, tile) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: tile.crossAxisCount,
                    mainAxisCellCount: tile.mainAxisCount,
                    child: ImageTile(
                      index: index,
                      width: tile.crossAxisCount * 100,
                      height: tile.mainAxisCount * 100,
                      imageUrl: searchDatas[index].feedImageUrl,
                    ),
                  );
                })
              ],
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 12.sp,
              ),
            );
          }
        });



*/

/*
class ProfileMediaPage extends StatefulWidget {
  const ProfileMediaPage({Key? key, required this.user, required this.userAll})
      : super(key: key);
  final User user;
  final IsolaUserAll userAll;
  @override
  _ProfileMediaPageState createState() => _ProfileMediaPageState();
}

class _ProfileMediaPageState extends State<ProfileMediaPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late var _refProfileMedia;
  //late var searchHistoryData;
  var searchFeed = <FeedMeta>[];



  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    // if failed,use refreshFailed()
    setState(() {
      // BasicGridWidget.explorerUpdate(widget.user);
      // BasicGridWidget.explorerGetter(widget.user);

      ProfileBasicGridWidget.gtGetterReset();
    });
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
  }

  /*
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }*/

    void _onLoading() async {
    List<ProfileGridTile> gTile = ProfileBasicGridWidget.feedValue;
    if (ProfileBasicGridWidget.feedValue.length >= feedAllControl) {
      /*
      setState(() {
        //   BasicGridWidget.gtMixer();
        BasicGridWidget.explorerGetter(widget.user);
        BasicGridWidget.gtGetterReset();
        _refreshController.loadComplete();
        // _onRefresh();
      });*/
      feedAllControl = 0;
      _refreshController.loadNoData();

      print("aha");
    } else {
      print("bscgridfeedvalue ${ProfileBasicGridWidget.feedValue.length}");

      // print("gtilelength ${gTile.length}");
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()

      if (mounted) {
        setState(() {
          ProfileBasicGridWidget.gtGetter();
          //   loadingValue = loadingValue + 1;
          //   print(loadingValue);
        });
      }
      _refreshController.loadComplete();
    }
  }

/*
  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }
*/
  @override
  void initState() {
    super.initState();
    _refProfileMedia = refGetter(
        enum2: RefEnum.Searchfeedsget,
        targetUid: "",
        crypto: '',
        userUid: widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: const ClassicFooter(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Container(
            color: ColorConstant.themeGrey,
            child: ProfileBasicGridWidget(
              key: widget.key,
              refProfileMedia: _refProfileMedia,
              userAll: widget.userAll,
            ),
          )),
    );
  }
}

class ProfileBasicGridWidget extends StatelessWidget {
  ProfileBasicGridWidget(
      {Key? key, required this.refProfileMedia, required this.userAll})
      : super(key: key);
  final DatabaseReference refProfileMedia;
  final IsolaUserAll userAll;
   static void gtGetterReset() {
    feedValue.clear();
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }


 static void gtGetter() {
    feedValue.addAll(tiles2);

    //  context.read<SearchCubit>().feedValueLoader(feedValue);
  }

static const tiles2 = [

   ProfileGridTile(2, 1),
 ProfileGridTile(1, 2),
     ProfileGridTile(2, 2),
     ProfileGridTile(1, 1),
    ProfileGridTile(2, 1),
   ProfileGridTile(1, 2),
  ProfileGridTile(2, 2),
     ProfileGridTile(1, 1),
 ProfileGridTile(2, 1),
     ProfileGridTile(1, 2),
 ProfileGridTile(2, 2),
    ProfileGridTile(1, 1),
    ProfileGridTile(2, 1),
   ProfileGridTile(1, 2),
 ProfileGridTile(2, 2),
   ProfileGridTile(1, 1),
 
  ];

   static var feedValue = <ProfileGridTile>[
    const ProfileGridTile(2, 1),
    const ProfileGridTile(1, 2),
    const ProfileGridTile(2, 2),
    const ProfileGridTile(1, 1),
    const ProfileGridTile(2, 1),
    const ProfileGridTile(1, 2),
    const ProfileGridTile(2, 2),
    const ProfileGridTile(1, 1),
    const ProfileGridTile(2, 1),
    const ProfileGridTile(1, 2),
    const ProfileGridTile(2, 2),
    const ProfileGridTile(1, 1),
    const ProfileGridTile(2, 1),
    const ProfileGridTile(1, 2),
    const ProfileGridTile(2, 2),
    const ProfileGridTile(1, 1),
  ];



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feeds')
            .doc(userAll.isolaUserMeta.userUid)
            .collection('image_feeds')
            .limit(feedValue.length)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            feedValue.clear();

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
                .toList();

            if (itemDatas.length != 0) {
              if (itemDatas.length > 9) {
                for (var i = 1; i < 9; i++) {
                //  feedValue.add(const ProfileGridTile(1, 2));
                }
              }
              for (var i = 1; i < itemDatas.length; i++) {
               // feedValue.add(const ProfileGridTile(1, 2));
              }
            }
               amountUpdater((itemDatas.length) - 20);

            print(itemDatas.length);
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
                      ...feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: GestureDetector(
                            onTap: () => _openDetail(
                                context,
                                index,
                                itemDatas,
                                userAll.isolaUserMeta.userUid,
                                userAll.isolaUserMeta,
                                index),
                            child: ImageTile(
                              postValue: itemDatas.length,
                              index: index,
                              width: tile.crossAxisCount * 100,
                              height: tile.mainAxisCount * 100,
                              imageUrl: itemDatas[index].feedImageUrl,
                            ),
                          ),
                        );
                      })
                    ],
                  );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 12.sp,
              ),
            );
          }
        });
  }
}

_openDetail(context, index, List<dynamic> imageItemList, String userUid,
    IsolaUserMeta userMeta, int sira) {
  print(userMeta.userToken);
  print(sira);
  //imageItemList.sort((a, b) => a.feedDate.compareTo(b.feedDate));

  List<dynamic> slicedList = imageItemList.slice(sira);

  final route = CupertinoPageRoute(
    builder: (context) => SearchDetail(
      index: index,
      imageItemList: slicedList,
      userUid: userUid,
      userMeta: userMeta,
      itemLoc: sira,
    ),
  );
  Navigator.push(context, route);
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.postValue,
    required this.imageUrl,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);
  final int postValue;
  final String imageUrl;
  final int index;
  final int width;
  final int height;

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
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
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

class ProfileGridTile {
  const ProfileGridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}



/*



return StreamBuilder<dynamic>(
        stream: refProfileMedia.onValue,
        builder: (context, event) {
          if (event.hasData) {
            feedValue.clear();
            var searchDatas = <FeedMeta>[];

            var gettingSearch = event.data.snapshot.value as Map;

            gettingSearch.forEach((key, value) {
              var imageFeed = FeedMeta.fromJson(value);

              if (imageFeed.feedIsImage == true &&
                  imageFeed.userUid == userAll.isolaUserMeta.userUid) {
                searchDatas.add(imageFeed);
                gridTileWithPostValue();
              }
            });

            return searchDatas.isEmpty
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
                      ...feedValue.mapIndexed((index, tile) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: tile.crossAxisCount,
                          mainAxisCellCount: tile.mainAxisCount,
                          child: ImageTile(
                            postValue: searchDatas.length,
                            index: index,
                            width: tile.crossAxisCount * 100,
                            height: tile.mainAxisCount * 100,
                            imageUrl: searchDatas[index].feedImageUrl,
                          ),
                        );
                      })
                    ],
                  );
          } else {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 12.sp,
              ),
            );
          }
        });







*/
*/
