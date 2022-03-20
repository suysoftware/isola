// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, avoid_init_to_null

import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isola_app/src/constants/color_constants.dart';
import 'package:isola_app/src/constants/style_constants.dart';
import 'package:isola_app/src/model/feeds/feed_meta.dart';
import 'package:isola_app/src/model/feeds/image_feed_meta.dart';
import 'package:isola_app/src/model/hive_models/user_hive.dart';
import 'package:isola_app/src/model/user/user_all.dart';
import 'package:isola_app/src/service/firebase/storage/explore_history.dart';
import 'package:isola_app/src/service/firebase/storage/feedshare/add_search_feed.dart';
import 'package:isola_app/src/widget/liquid_progress_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
import '../service/firebase/storage/feedshare/add_image_feeds.dart';

int feedAllControl = 0;
void amountUpdater(int updateValue) async {
  feedAllControl = updateValue;
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.user, required this.userAll})
      : super(key: key);
  final User user;
  final IsolaUserAll userAll;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 50,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(1.0),
                  onPressed: () async => addSearchItemDialogContent(context),
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: Image.asset(
                        "asset/img/search_page_cam_icon.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: ColorConstant.milkColor,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Explorer"),
          ),
        ),
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            footer: const ClassicFooter(),
            header: const ClassicHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Container(
              color: ColorConstant.themeGrey,
              child: BasicGridWidget(
                key: widget.key,
              ),
            )));
  }

  addSearchItemDialogContent(BuildContext context) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Center(
        child: AddSearchItemContainer(
          userAll: widget.userAll,
        ),
      ),
    );
  }
}

int downloadedItem = 0;

class BasicGridWidget extends StatefulWidget {
  const BasicGridWidget({
    Key? key,
  }) : super(key: key);

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
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
    GridTile(2, 1),
    GridTile(1, 2),
    GridTile(2, 2),
    GridTile(1, 1),
  ];

  static var feedValue = <GridTile>[
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
    const GridTile(2, 1),
    const GridTile(1, 2),
    const GridTile(2, 2),
    const GridTile(1, 1),
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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('image_feeds')
            .limit(BasicGridWidget.feedValue.length + 30)
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
                    doc['user_avatar_url'],
                    doc['user_name'],
                    doc['user_uid'],
                    doc['user_loc'],
                    doc['feed_visibility'],
                    doc['feed_report_value']))
                .toList();
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
                          child: ImageTile(
                            index: index,
                            width: tile.crossAxisCount * 100,
                            height: tile.mainAxisCount * 100,
                            //   imageUrl: searchDatas[index].feedImageUrl,
                            imageUrl: itemDatas[index].feedImageUrl,
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
              child: FullScreenWidget(
                disposeLevel: DisposeLevel.Low,
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
      ),
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

class AddSearchItemContainer extends StatefulWidget {
  const AddSearchItemContainer({Key? key, required this.userAll})
      : super(key: key);
  final IsolaUserAll userAll;

  @override
  State<AddSearchItemContainer> createState() => _AddSearchItemContainerState();
}

class _AddSearchItemContainerState extends State<AddSearchItemContainer>
    with TickerProviderStateMixin {
  var t1 = TextEditingController();

  File? file = null;
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 800,
        imageQuality: 100);
    file = File(xfile!.path);
    setState(() {});
  }

  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 95.w,
      decoration: BoxDecoration(
          gradient: ColorConstant.isolaMainGradient,
          border: Border.all(color: ColorConstant.transparentColor),
          borderRadius: const BorderRadius.all(Radius.circular(25.0))),
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: ColorConstant.milkColor,
              border: Border.all(color: ColorConstant.transparentColor),
              borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CupertinoButton(
                      child: const Icon(
                        CupertinoIcons.xmark,
                        color: ColorConstant.softBlack,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.w, 2.h, 0.0, 0.0),
                child: SizedBox(
                  height: 45.h,
                  width: 95.w,
                  // color: ColorConstant.addTimelinePost,
                  child: file == null
                      ? GestureDetector(
                          onTap: () {
                            print("dd");
                            chooseImage();
                          },
                          child: ClipOval(
                            child: Icon(
                              CupertinoIcons.photo_camera_solid,
                              size: 70.sp,
                              color: ColorConstant.themeGrey,
                            ),
                          ),
                        )
                      : ExtendedImage.file(
                          file!,
                          fit: BoxFit.contain,
                          mode: ExtendedImageMode.editor,
                          extendedImageEditorKey: editorKey,
                          initEditorConfigHandler: (state) {
                            return EditorConfig(
                                cornerColor: ColorConstant.iGradientMaterial4,
                                maxScale: 4.0,
                                cropRectPadding: const EdgeInsets.all(15.0),
                                hitTestSize: 10.0,
                                initCropRectType: InitCropRectType.imageRect,
                                cropAspectRatio: CropAspectRatios.ratio8_10,
                                editActionDetailsIsChanged:
                                    (EditActionDetails? details) {
                                  //print(details?.totalScale);
                                });
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      gradient: ColorConstant.isolaMainGradient,
                      border: Border.all(color: ColorConstant.transparentColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(1.0),
                      onPressed: () async {
                        String fileID = const Uuid().v4();
                        uploadImage(widget.userAll.isolaUserMeta.userUid, file!,
                                fileID)
                            .then((value) {
                          addImageFeedToDatabase(
                              widget.userAll.isolaUserMeta.userUid,
                              widget.userAll.isolaUserDisplay.avatarUrl,
                              value,
                              fileID);
                        }).whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          setState(() {});
                        });

                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AnimatedLiquidCircularProgressIndicator());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            color: ColorConstant.themeGrey,
                            border: Border.all(
                                color: ColorConstant.transparentColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0))),
                        child: Center(
                          child: Text(
                            "Post",
                            style: StyleConstants.postAddTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CropAspectRatios {
  /// no aspect ratio for crop
  //static const double custom = null;

  /// the same as aspect ratio of image
  /// [cropAspectRatio] is not more than 0.0, it's original
  static const double original = 0.0;

  /// ratio of width and height is 1 : 1
  static const double ratio1_1 = 1.0;

  /// ratio of width and height is 3 : 4
  static const double ratio3_4 = 3.0 / 4.0;

  /// ratio of width and height is 4 : 3
  static const double ratio4_3 = 4.0 / 3.0;

  /// ratio of width and height is 8 : 10
  static const double ratio8_10 = 8.0 / 10.0;

  /// ratio of width and height is 9 : 16
  static const double ratio9_16 = 9.0 / 16.0;

  /// ratio of width and height is 16 : 9
  static const double ratio16_9 = 16.0 / 9.0;
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